Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129574AbRBMT4l>; Tue, 13 Feb 2001 14:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbRBMT4b>; Tue, 13 Feb 2001 14:56:31 -0500
Received: from www.wen-online.de ([212.223.88.39]:14347 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129868AbRBMT4S>;
	Tue, 13 Feb 2001 14:56:18 -0500
Date: Tue, 13 Feb 2001 20:56:10 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with Ramdisk in linux-2.4.1 
In-Reply-To: <005e01c095f0$6c1b6c00$bba6b3d0@Toshiba>
Message-ID: <Pine.Linu.4.10.10102132042480.755-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Jaswinder Singh wrote:

> Dear Mike and others ,
> 
> I am using compressed ramdisk , i can not turn off cramfs .

(ok.. really is compressed)

> my error messages are very strange and irreregular .
> 
> i am getting 3 different kind of error messages :-
> 
> invalid compressed format (err=1)
> OR
> invalid compressed format (err=2)
> OR
> crc error
> 
> I am using gzip 1.2.4 (18 Aug 93)
> 
> But when i use same ramdisk with old kernel like 2.2.12 , it works fine .

Can you point me to a cramfs generation procedure?  (never used
cramfs.. know where the docs are, but could use a small time warp) 

	-Mike

