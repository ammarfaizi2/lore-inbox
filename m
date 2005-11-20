Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVKTRgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVKTRgs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 12:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVKTRgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 12:36:48 -0500
Received: from cantor2.suse.de ([195.135.220.15]:22461 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751292AbVKTRgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 12:36:47 -0500
Date: Sun, 20 Nov 2005 17:10:47 +0100
From: "Andi Kleen" <ak@suse.de>
To: linux-kernel@vger.kernel.org, asmith@vtrl.co.uk
Message-ID: <4380A007.mail51L11JX15@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sender: ak@brahms.suse.de
To: asmith@vtrl.co.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
References: <437F63C1.6010507@perkel.com>
	<1132431907.19692.15.camel@localhost.localdomain>
	<437F9705.80503@perkel.com> <200511192304.16302.s0348365@sms.ed.ac.uk>
	<Pine.LNX.4.61.0511200718530.25549@vtrl22.vtrl.co.uk>
From: Andi Kleen <ak@suse.de>
Date: 20 Nov 2005 17:10:47 +0100
In-Reply-To: <Pine.LNX.4.61.0511200718530.25549@vtrl22.vtrl.co.uk>
Message-ID: <p73hda7i9ko.fsf@brahms.suse.de>
Lines: 9
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

asmith@vtrl.co.uk writes:

> I would agree with your view on IDE becoming obsolete on hard drives,
> but I as yet, am not aware of any CD/DVD drives with a SATA interface.

Plextor is shipping one for example. There are probably more.
Unfortunately the S-ATAPI support in Linux seems to be still WIP.

-Andi
