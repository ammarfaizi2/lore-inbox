Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269034AbTBXAkF>; Sun, 23 Feb 2003 19:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269035AbTBXAkF>; Sun, 23 Feb 2003 19:40:05 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:30874 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP
	id <S269034AbTBXAkF>; Sun, 23 Feb 2003 19:40:05 -0500
Message-Id: <5.1.0.14.0.20030223164708.00a76630@incoming.verizon.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 23 Feb 2003 16:48:03 -0800
To: Andries Brouwer <aebr@win.tue.nl>
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
Subject: Re: [RFC] seq_file_howto
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030223101033.GA13356@win.tue.nl>
References: <3E584805.DE41B7E9@verizon.net>
 <3E584805.DE41B7E9@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [4.64.238.61] at Sun, 23 Feb 2003 18:50:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:10 AM 2/23/2003 +0100, Andries Brouwer wrote:
>On Sat, Feb 22, 2003 at 08:03:17PM -0800, Randy.Dunlap wrote:
>
> > acme prodded me into doing this a few weeks (or months?) ago.
> > It still needs some additional info for using single_open()
> > and single_release(), but I'd like to get some comments on it
> > and then add it to linux/Documentation/filesystems/ or post it
> > on the web somewhere, like kernelnewbies.org.
> >
> > Comments, corrections?
>
>By some coincidence I also wrote some text recently.
>Take whatever you want from the below.
>(For example, this mentions the use of private_data.)
>
>Andries

Thanks, I'll merge them.
I was going to add some data structure info as well.

~Randy


