Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbTBJFcu>; Mon, 10 Feb 2003 00:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTBJFcu>; Mon, 10 Feb 2003 00:32:50 -0500
Received: from webmail27.rediffmail.com ([203.199.83.37]:20181 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S262838AbTBJFcs>;
	Mon, 10 Feb 2003 00:32:48 -0500
Date: 10 Feb 2003 05:48:16 -0000
Message-ID: <20030210054816.6191.qmail@webmail27.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: File systems in embedded devices
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear David,

Thanks for your response.

I sent it correctly after typing the full mail. I think this is 
some problem in rediff mails itself.
Anyway these are the my requirements:

1) My application is coming around 8 MB. So need a file system 
about 12 MB to which i should be able to mount the root of the 
Linux kernel.

2) I need read-only file system.

3) Is it possible to create multiple ram disks of multiple file 
systems like CRAMFS, RAMDISK for a single kernel?

Thanks in advance,
Nanda

On Sun, 09 Feb 2003 David Woodhouse wrote :
>On Sat, 2003-02-08 at 14:20, Nandakumar NarayanaSwamy wrote:
> > Dear All,
> >
> > We are developing a embedded device based on linux. Through 
>the
> > development phase we used NFS. But now we want to move some
> > filesystem which can be created in FLASH/RAM.
>
>Which? Flash or RAM?
>
> > Can anybody suggest me some ideas so that i can solve these
> > issues?
>
>You need to give at least _some_ indication of your requirements 
>--
>what's on your file system, what is the expected pattern of 
>access to
>it, do you require write access all the time or only occasional 
>updates
>of the whole system, etc. ?
>
>
>--
>dwmw2
>


