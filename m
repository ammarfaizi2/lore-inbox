Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSGAQ2G>; Mon, 1 Jul 2002 12:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSGAQ2F>; Mon, 1 Jul 2002 12:28:05 -0400
Received: from realimage.realnet.co.sz ([196.28.7.3]:34984 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315746AbSGAQ2E>; Mon, 1 Jul 2002 12:28:04 -0400
Date: Mon, 1 Jul 2002 17:59:27 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
In-Reply-To: <200207011815.36602.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.44.0207011758180.3104-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Roy Sigurd Karlsbakk wrote:

> LABEL=/                 /                       ext3    defaults        1 1
> /dev/md2                /tmp                    ext3    defaults        1 2
> /dev/md3                /var                    jfs     defaults        1 2
> /dev/md4                /data                   jfs     defaults        1 2
> /dev/md1                swap                    swap    defaults        0 0

One small thing, you do know that you can interleave swap?

Regards,
	Zwane

-- 
http://function.linuxpower.ca
		

