Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTBIEdR>; Sat, 8 Feb 2003 23:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbTBIEdQ>; Sat, 8 Feb 2003 23:33:16 -0500
Received: from webmail32.rediffmail.com ([203.199.83.32]:4000 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S267163AbTBIEdQ>;
	Sat, 8 Feb 2003 23:33:16 -0500
Date: 9 Feb 2003 04:49:50 -0000
Message-ID: <20030209044950.3898.qmail@webmail32.rediffmail.com>
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

Thanks for your inputs.
Actually i have 8 MB flash and 32 MB RAM in my target board.
I need to create a read-only file system either in flash or RAM 
which should be able to accomodate our application which is about 
8 MB (stripped one).

Thanks again for your response.

with best regards,
Purush

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


