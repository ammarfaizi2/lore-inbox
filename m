Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUE1M5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUE1M5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUE1M5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:57:13 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:33505 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262866AbUE1M5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:57:08 -0400
Date: Fri, 28 May 2004 13:54:47 +0100
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
Message-ID: <20040528125447.GB11265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@muc.de>,
	Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20Oc4-HT-25@gated-at.bofh.it> <m3zn7su4lv.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3zn7su4lv.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 02:18:52PM +0200, Andi Kleen wrote:

 > > simplify DMI blacklist table by removing the need to fill
 > > unused slots with NO_MATCH macro.
 > 
 > Can you please delay that patch for 2.7?
 > 2.6 is for bug fixes, not for cleanups.
 > 
 > There are large third party patchkits for DMI and "cleaning up" 
 > the format will just cause lots of rejects and pain. 

Alternatively, those third parties could get their act
together and submit those patches back upstream.

		Dave

