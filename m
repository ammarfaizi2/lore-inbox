Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbULZXTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbULZXTS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 18:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbULZXTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 18:19:18 -0500
Received: from mxin.widomaker.com ([204.17.220.7]:58121 "EHLO
	mxin.widomaker.com") by vger.kernel.org with ESMTP id S261316AbULZXTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 18:19:14 -0500
Date: Sun, 26 Dec 2004 18:17:49 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-cd hang while playing a CD in 2.6.10
Message-ID: <20041226231746.GA3806@widomaker.com>
References: <20041225234342.GA5177@widomaker.com> <41CEBCE4.9030602@benton987.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CEBCE4.9030602@benton987.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
X-Spam-Score: -4.9 (----)
X-Spam-Report: This message has been scanned & scored by widomaker.com's mail servers.
	The information added to this message is to allow you to chose whether
	or not you accept this message.  For more information, contact
	helpdesk@widomaker.com or see http://www.widomaker.com/filterspam.html
	Content analysis details:   (-4.9 points, 9.0 required)
	BAYES_00=-4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, 26 Dec 2004 @ 13:30 +0000, Andrew Benton said:

> Charles Shannon Hendrix wrote:
> >
> >I have a repeatable problem playing music CDs with kernel 2.6.8.1 and
> >2.6.10.
> >
> >Running "gnome-cd" to play a CD, the drive and IDE bus flash a few times
> >for about 15 seconds, and then the IDE bus light goes solid.
>
> Does it work if you use a different application? Gnome-cd has never 
> worked for me but Totem (with an xine backend) is playing CD's fine with 
> a 2.6.10 kernel for me.

Totem does work.

However, there is still obviously something wrong when an application
can hang up a driver like gnome-cd seems to be doing.



-- 
shannon "AT" widomaker.com -- ["The determined programmer can write a
FORTRAN program in any language." ]
