Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbTCXXN6>; Mon, 24 Mar 2003 18:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbTCXXN6>; Mon, 24 Mar 2003 18:13:58 -0500
Received: from mail136.mail.bellsouth.net ([205.152.58.96]:10899 "EHLO
	imf48bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S261191AbTCXXN5>; Mon, 24 Mar 2003 18:13:57 -0500
Subject: Re: CONFIG_VT_CONSOLE in 2.5.6x ?
From: Louis Garcia <louisg00@bellsouth.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <33453.4.64.238.61.1048547120.squirrel@www.osdl.org>
References: <1048546447.3058.3.camel@tiger>
	 <33453.4.64.238.61.1048547120.squirrel@www.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048548310.3388.7.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 24 Mar 2003 18:25:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I can't find it there. I have a 2.5.65 tree and under character
devices I have

[ ] Non-standard serial port support
    Serial drivers --->
[ ] Unix98 PTY support
(2048) Maximum number of Unix98 PTYs in use (0-2048)
[ ] Parallel Printer support 


I see nothing for Virtual terminal in this sub-menu. Does this depend on
another option?

--Lou


On Mon, 2003-03-24 at 18:05, Randy.Dunlap wrote:
> > I can't find CONFIG_VT_CONSOLE anywhere in menuconfig. I am having problems
> > not viewing the bootup messages on my monitor. I do have
> > console=tty0 in grub.conf.
> 
> It's the second line of the Character Devices menu:
> 
>   &#9474; &#9474;[*] Virtual terminal
>   &#9474; &#9474;[*]   Support for console on virtual terminal     <<<<<
> 
> ~Randy
> 
> 
> 

