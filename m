Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTDGQep (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTDGQep (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:34:45 -0400
Received: from main.gmane.org ([80.91.224.249]:34979 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263558AbTDGQeo (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:34:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <dragon@gentoo.org>
Subject: Re: [2.5.66-bk12] drivers/video/matrox/matroxfb_base.h:52:25: video/fbcon.h:
 No such file or directory
Date: Mon, 07 Apr 2003 12:41:16 -0400
Message-ID: <3E91AA2C.9090808@gentoo.org>
References: <E192Yij-0004GP-00@Maya.ny.ranok.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vagn Scott wrote:
> config is below
> Mon Apr  7 11:00:18 EDT 2003
> 2.5.66
> patch-2.5.66-bk12.bz2
> (please CC: me, as I'm not on the list)
> --------------------------------
> 
> In file included from drivers/video/matrox/matroxfb_base.c:105:
> drivers/video/matrox/matroxfb_base.h:52:25: video/fbcon.h: No such file or directory
> drivers/video/matrox/matroxfb_base.h:53:30: video/fbcon-cfb4.h: No such file or directory
> drivers/video/matrox/matroxfb_base.h:54:30: video/fbcon-cfb8.h: No such file or directory
> drivers/video/matrox/matroxfb_base.h:55:31: video/fbcon-cfb16.h: No such file or directory

Petr usually keeps 2.5 patches for the matroxfb on his ftp 
site.  Having just looked, this seems promising:
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-2.5.66-bk12.gz

Cheers,
Nicholas


