Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSLVOwe>; Sun, 22 Dec 2002 09:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbSLVOwe>; Sun, 22 Dec 2002 09:52:34 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:31632 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264624AbSLVOwd> convert rfc822-to-8bit; Sun, 22 Dec 2002 09:52:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Read this and be ashamed ;) or: Awfull performance loss since 2.4.18 to 2.4.21-pre2
Date: Sun, 22 Dec 2002 15:57:11 +0100
User-Agent: KMail/1.4.3
References: <200212221439.28075.m.c.p@wolk-project.de> <200212221538.32354.m.c.p@wolk-project.de>
In-Reply-To: <200212221538.32354.m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212221557.11563.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 December 2002 15:38, Marc-Christian Petersen wrote:

And hi again ^3,

> root@codeman:[/] # uname -r
> 2.4.20-rmap15b
> root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
> 131072+0 records in
> 131072+0 records out
> 2147483648 bytes transferred in 140.460427 seconds (15288887 bytes/sec)

root@codeman:[/] # uname -r
2.4.20aa1
root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 286.054011 seconds (7507266 bytes/sec)

ciao, Marc


