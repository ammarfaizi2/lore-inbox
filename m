Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268714AbUIXMaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbUIXMaf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUIXMaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:30:35 -0400
Received: from muffin.area.ba.cnr.it ([150.145.80.101]:28652 "EHLO
	muffin.area.ba.cnr.it") by vger.kernel.org with ESMTP
	id S268714AbUIXMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:30:34 -0400
Date: Fri, 24 Sep 2004 14:30:29 +0200
From: "Francesco P. Lovergine" <lovergine@ba.issia.cnr.it>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI problems with a Presario 2700...
Message-ID: <20040924123029.GH13407@ba.issia.cnr.it>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4154039A.9020003@voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4154039A.9020003@voicenet.com>
X-GPG-key: finger frankie@db.debian.org
X-GPG-fingerprint: 92E4 2D44 336F DF91 5508  23D5 A453 5199 E9F2 C747
X-Spot: Who uses non-free software empoisons you, too. Say him to stop.
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 07:23:06AM -0400, Adam K Kirchhoff wrote:
> 
> I'm trying to get ACPI working on a Presario 2700, but I'm running into 
> a problem:
> 
> ACPI: Subsystem revision 20040326
> ACPI: IRQ9 SCI: Level Trigger.
> 
> Has anyone seen this before and have some idea how to fix it?  Or does 
> the 2700 just have a really crappy ACPI implementation? :-)
> 

Workaround: nolapic arg at boot when acpi=on.

-- 
Francesco P. Lovergine
