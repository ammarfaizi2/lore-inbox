Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288548AbSAUWDy>; Mon, 21 Jan 2002 17:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288671AbSAUWDo>; Mon, 21 Jan 2002 17:03:44 -0500
Received: from mnh-1-01.mv.com ([207.22.10.33]:7687 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288548AbSAUWD3>;
	Mon, 21 Jan 2002 17:03:29 -0500
Message-Id: <200201212204.RAA03719@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: bulb@ucw.cz
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 OOPS in tty code. 
In-Reply-To: Your message of "Mon, 21 Jan 2002 15:10:37 +0100."
             <20020121151037.A21622@ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jan 2002 17:04:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bulb@ucw.cz said:
> Tty device code causes oopses when closing /dev/console and devfs is
> used. The bug is reproducible on 2.4.17 UML port.

How do you reproduce it?

UML config, command line, a backtrace, etc would be nice.

				Jeff

