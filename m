Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSIXKaw>; Tue, 24 Sep 2002 06:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSIXKaw>; Tue, 24 Sep 2002 06:30:52 -0400
Received: from mail.rdsor.ro ([193.231.238.10]:42166 "HELO mail.rdsor.ro")
	by vger.kernel.org with SMTP id <S261640AbSIXKav> convert rfc822-to-8bit;
	Tue, 24 Sep 2002 06:30:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Balint Cristian <rezso@rdsor.ro>
To: "Nandakumar NarayanaSwamy" <nanda_kn@rediffmail.com>,
       linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: Maximum RAM Disk Size
Date: Tue, 24 Sep 2002 13:40:32 -0400
User-Agent: KMail/1.4.3
References: <20020822065939.15638.qmail@mailweb33.rediffmail.com>
In-Reply-To: <20020822065939.15638.qmail@mailweb33.rediffmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209241340.32266.rezso@rdsor.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 August 2002 02:59, Nandakumar NarayanaSwamy wrote:
> Hi Folks,
>
> Does it possible to have 16 MB RAM DISK based file system on a
> machine with 32 MB Ram?
Yes but not using bash and shared libs like glibc.

  i think if use anything staticaly compiled it is posible with tcsh or a 
smaller interpreter and try to do cramfs.Otherwise is too small space ....

 Eventualy try to take a look of some distro's cd boot and if good enogh for 
you try compile it to mips. 

>
> Thanks in Advance,
>
> with best regards,
> Nanda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-mips" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

