Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTENNGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTENNGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:06:52 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:61361 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262090AbTENNGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:06:51 -0400
Message-ID: <3EC2426D.9060606@myrealbox.com>
Date: Wed, 14 May 2003 06:19:41 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4a) Gecko/20030415
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pau Aliagas <linuxnow@newtral.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.69
References: <fa.jcpkvvc.1h32u9k@ifi.uio.no>
In-Reply-To: <fa.jcpkvvc.1h32u9k@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pau Aliagas wrote:
> I still find no way to boot a 2.5.69 kernel.
> It reports: "no console found, specify init= option"
> But the console is specified and the messages appear till this point:
> 
> This is the relevant part of my config:


I have CONFIG_VT=y at this spot in 'character devices'.

> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_LP_CONSOLE is not set
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y

