Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVLFBsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVLFBsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVLFBsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:48:25 -0500
Received: from mail.dvmed.net ([216.237.124.58]:18576 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964907AbVLFBsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:48:24 -0500
Message-ID: <4394EDDE.30605@pobox.com>
Date: Mon, 05 Dec 2005 20:48:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620264.2171.14.camel@localhost.localdomain> <4394C745.2020802@tmr.com>
In-Reply-To: <4394C745.2020802@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Bill Davidsen wrote: > I do think the old model was
	better; by holding down major changes for > six months or so after a
	new even release came out, people had a chance > to polich the stable
	release, and developers had time to recharge their > batteries so to
	speak, and to sit and think about what they wanted to > do, without
	feeling the pressure to write code and submit it right away. > Knowing
	that there's no place to send code for six months is a great aid > to
	generating GOOD code. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I do think the old model was better; by holding down major changes for 
> six months or so after a new even release came out, people had a chance 
> to polich the stable release, and developers had time to recharge their 
> batteries so to speak, and to sit and think about what they wanted to 
> do, without feeling the pressure to write code and submit it right away. 
> Knowing that there's no place to send code for six months is a great aid 
> to generating GOOD code.

It never worked that way, which is why the model changed.

Like it or not, developers would only focus on one release.  In the old 
model, unstable things would get shoved into the stable kernel, because 
people didn't want to wait six months.  And for the unstable kernel, it 
would often be so horribly broken that even developers couldn't use it 
for development (think 2.5.x IDE).

	Jeff


