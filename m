Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWHTWOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWHTWOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWHTWOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:14:55 -0400
Received: from main.gmane.org ([80.91.229.2]:20917 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751630AbWHTWOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:14:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Bug Report 2.6.17.8
Date: Mon, 21 Aug 2006 01:14:40 +0200
Organization: Palacky University in Olomouc, experimental physics dep.
Message-ID: <44E8ECE0.1080100@flower.upol.cz>
References: <20060820134022.c1d676d6.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <20060820134022.c1d676d6.skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> Hello,
> 
> in case of additional questions feel free to ask. 
> 
,-
|uname -a
|cat /proc/mounts || mount
`-
But no. Keep it to yourself!


kernel:  <c0149797> slab_destroy+0x21/0x4e  <c0176e09> dquot_drop+0x5b/0x68
kernel:  <c01983d4> reiserfs_dquot_drop+0x37/0x74  <c01cedb6> memmove+0x20/0x26
kernel:  <c0162571> clear_inode+0x13d/0x13f  <c016258e> dispose_list+0x1b/0xaa

... reiserfs.

-- 
-o--=O`C  /. .\ (???)  (+)                                    /o o\
  #oo'L O      o         |                                     o.
<___=E M    ^--         |  (you're barking up the wrong tree) =--'

