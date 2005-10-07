Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbVJGRcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbVJGRcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030523AbVJGRcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:32:01 -0400
Received: from main.gmane.org ([80.91.229.2]:12930 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030481AbVJGRcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:32:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: 'Undeleting' an open file
Date: Fri, 7 Oct 2005 19:25:21 +0200
Message-ID: <s0xrky1ov0zp.p0feejo522h7$.dlg@40tude.net>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <43442D19.4050005@perkel.com> <Pine.LNX.4.58.0510052208130.4308@be1.lrz> <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net> <di60qd$sbp$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-51-179.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005 14:30:37 +0000 (UTC), Miquel van Smoorenburg wrote:

> In article <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>,
> Giuseppe Bilotta  <bilotta78@hotpop.com> wrote:
>>On Wed, 5 Oct 2005 23:05:34 +0200 (CEST), Bodo Eggert wrote:
>>
>>> Files are deleted if the last reference is gone. If you play a music file
>>> and unlink it while it's playing, it won't be deleted untill the player
>>> closes the file, since an open filehandle is a reference.
>>
>>BTW, I've always wondered: is there a way to un-unlink such a file?
> 
> Around 2.4.15 we had the same discussion here - see for example
> http://www.ussg.iu.edu/hypermail/linux/kernel/0201.2/0881.html
> (but be sure to read the whole thread).

A very interesting read, thank you for the link.

-- 
Giuseppe "Oblomov" Bilotta

Axiom I of the Giuseppe Bilotta
theory of IT:
Anything is better than MS

