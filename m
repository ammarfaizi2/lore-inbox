Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263406AbRFKEl3>; Mon, 11 Jun 2001 00:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbRFKElS>; Mon, 11 Jun 2001 00:41:18 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:52741 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S263405AbRFKElM>; Mon, 11 Jun 2001 00:41:12 -0400
Date: Mon, 11 Jun 2001 10:29:34 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: exec format error
In-Reply-To: <Pine.LNX.4.10.10106031716330.3971-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10106111022240.7084-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry to disturb you.

I have written a file system in 2.2.14 kernel similar to ramfs on 2.5
kernel. I am able to register,mount and do file and directory operations.
I tried to write a C program and compile it. The compilation gave me the
object file. When i tried to run the object file it gave me an error 
" cannot execute binary file". I entered gdb and  I could get the error
"exec format error". What is exec format error and what is it because of?
Please help me out with this info.

Thanks in advance,

Regards,
sathish


