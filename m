Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288047AbSBIWgh>; Sat, 9 Feb 2002 17:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSBIWg1>; Sat, 9 Feb 2002 17:36:27 -0500
Received: from mail.gmx.de ([213.165.64.20]:30230 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S288047AbSBIWgY>;
	Sat, 9 Feb 2002 17:36:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Felix Seeger <felix.seeger@gmx.de>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Subject: Re: sonypi in 2.4.18-pre9
Date: Sat, 9 Feb 2002 23:30:06 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020209115453Z288878-13996+19685@vger.kernel.org> <E16ZcwO-0000ee-00@smtp.fr.alcove.com> <20020209200609.GC32401@come.alcove-fr>
In-Reply-To: <20020209200609.GC32401@come.alcove-fr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020209223624Z288047-13996+20004@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There I had the problem that spicctrl always told me and error with ioctl
> > or so.
> > Maybe this error is gone because I have compilde the kernel with io
> > Device support.
>
> ???

Maybe my english is bad ;)
With kernel 2.4.17, spicctrl -p shows an error message:
ioctl failed: Invalid argument


With kernel 2.4.18-pre9 it works fine, the only difference between the config 
is that I have enabled IO Device Support.
I don't know what this is and maybe I don' need it.
I've only activated it because of the error message (ioctl failed)


have fun
HAL
