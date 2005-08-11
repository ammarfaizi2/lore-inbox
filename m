Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVHKT3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVHKT3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVHKT3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:29:31 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:62123 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S932411AbVHKT3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:29:30 -0400
Date: Thu, 11 Aug 2005 22:29:28 +0300
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
Message-ID: <20050811192928.GH31158@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <42FB8E91.9040905@gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke <iogl64nx@gmail.com> wrote:
> USB works also great for all chipsets :-)

Not here. I've had plenty of problems with VIA K8T800 USB, but only 
with USB mass storage devices:

	http://bugzilla.kernel.org/show_bug.cgi?id=2915

Otherwise the chipset has worked very well. Only one crash in 
a year, and that was with a recent 2.6.13-rc[2-5] TCP bug, which has 
already been fixed.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
