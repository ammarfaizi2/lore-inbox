Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261647AbSJJSET>; Thu, 10 Oct 2002 14:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbSJJSET>; Thu, 10 Oct 2002 14:04:19 -0400
Received: from pyxis.eclipse.net.uk ([212.104.129.226]:15635 "HELO
	pyxis.eclipse.net.uk") by vger.kernel.org with SMTP
	id <S261647AbSJJSER> convert rfc822-to-8bit; Thu, 10 Oct 2002 14:04:17 -0400
From: morgad <morgad@eclipse.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 compiling
Date: Thu, 10 Oct 2002 19:08:40 +0100
Organization: the great unwashed
Reply-To: morgad@eclipse.co.uk
Message-ID: <0ufbqu825c05tlu97unvmlcmq1ujbvsnjp@4ax.com>
X-Mailer: Forte Agent 1.92/32.572
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently running 2.4.19 successfully on
my K7 based Debian 3.0 box.

I thought I would try to test the new 2.5 series
kernels, however having tried 2.5.40, 2.5.40-ac5,
2.5.41 and 2.5.41-ac2 I am unable to compile any of them !

they all fail in the drivers/video area.

I got my config file by copying the working
2.4.19 one over and running 'make oldconfig'

(is there an better way of migrating configs
between kernel series ?)

I have put my current config at

http://www.eclipse.co.uk/morgd/linux  

could someone please check it and tell me how I have
broken things ?

(video card is radeon 7500)

best regards
dave morgan

