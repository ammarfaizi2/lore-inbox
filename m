Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSEUNza>; Tue, 21 May 2002 09:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314609AbSEUNz3>; Tue, 21 May 2002 09:55:29 -0400
Received: from linux2.ipc.pku.edu.cn ([162.105.177.40]:60034 "EHLO
	mdl.ipc.pku.edu.cn") by vger.kernel.org with ESMTP
	id <S314602AbSEUNz3>; Tue, 21 May 2002 09:55:29 -0400
Date: Tue, 21 May 2002 22:01:29 +0800 (CST)
From: Chen Hao <chen@mdl.ipc.pku.edu.cn>
To: <linux-kernel@vger.kernel.org>
Subject: kernel bug
Message-ID: <Pine.LNX.4.33.0205212143080.9615-100000@mdl.ipc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    My linux box has some problems recently. After using computer
for a while(serveral hours or serveral days), the file operation
for example, mv and link, couldn't work. But I can execute these
commands in remote machines successfully(Filesystem shares by nfs).  

    The configuration of my linux box is the following:

Hardware: Athlon XP1700/EPOX 8KHA+/3*256M DDR/TNT2
Software: kernel 2.4.18/XFree86 4.1.0

