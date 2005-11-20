Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVKTREL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVKTREL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 12:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVKTREL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 12:04:11 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:37213 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751289AbVKTREK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 12:04:10 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git pull 00/14] Input updates for 2.6.15
Date: Sun, 20 Nov 2005 12:04:07 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051120063611.269343000.dtor_core@ameritech.net>
In-Reply-To: <20051120063611.269343000.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511201204.08012.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 01:36, Dmitry Torokhov wrote:
> Hi Linus,
> 
> Please consider pulling from:
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
> 
> It corrects couple of problems caused by recein input dynalloc
> conversion, converts uinput driver to dynamic allocation and
> adds new wistron button driver which was siting in -mm for quite
> a while.
> 

Linus, please hold off the pull - I messed up authorship of Wistron
driver in commit history plus there is another fix for cinergyT2 driver.

I will redo the tree...

-- 
Dmitry
