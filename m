Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285647AbRLGXLe>; Fri, 7 Dec 2001 18:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285637AbRLGXLY>; Fri, 7 Dec 2001 18:11:24 -0500
Received: from twardziel.tenbit.pl ([195.205.163.235]:54150 "EHLO tenbit.pl")
	by vger.kernel.org with ESMTP id <S285649AbRLGXLN>;
	Fri, 7 Dec 2001 18:11:13 -0500
Date: Sat, 8 Dec 2001 00:11:13 +0100
From: =?iso-8859-2?Q?Mateusz_=A3oskot?= <m.loskot@chello.pl>
To: linux-kernel@vger.kernel.org
Cc: Mateusz ?oskot <m.loskot@chello.pl>, ftpadmin@kernel.org
Subject: Re: Strange problem with 2.4.x kernel
Message-ID: <20011208001113.C4239@cheetah.chello.pl>
Reply-To: m.loskot@chello.pl
Mail-Followup-To: =?iso-8859-2?Q?Mateusz_=A3oskot?= <m.loskot@chello.pl>,
	linux-kernel@vger.kernel.org, ftpadmin@kernel.org
In-Reply-To: <20011206190454.B848@cheetah.chello.pl> <20011206123342.42179ed3.reynolds@redhat.com> <20011206194151.D848@cheetah.chello.pl> <20011207222457.A939@go.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207222457.A939@go.cz>; from johnydog@go.cz on Fri, Dec 07, 2001 at 10:24:58PM +0100
X-Os: Linux cheetah 2.4.4 
X-Mailer: MUTT http://www.mutt.org
X-Accept-Language: en pl
X-Location: Europe, Poland, Warsaw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is your line speed ? 

I have CABLE MODEM connection and I have aout 40 kbps speed from ftp.krenel.org 
I think it is not so slow ;-))), I get linux kernel archive in 10 minutes ;)

> ProFTPD 1.2.0rcX and 1.2.2rcX (and probably other
> versions) corrupts data on slow links (e.g modem) when compiled with
> --enable-sendfile option (default). Could you try downloading on fast link,
> or from mirrors ?

I tried download from different places. So, it doesn't work.

As I said before in my posts, I suspect my RAM SIMM's (thanks to kernel hackers which gave me a lot of help)
So, I have to test it and I will know whats going wrong.

> To ftpadmin@kernel.org:
> Could you please check ? Thanks.

I think that this is problem with BIG tar.gz files, because if I try to ungzip 
kernel 2.2.19 everything goes fine, so it must be a hardware problem.

Thanks a lot for your help

-- 
Mateusz £oskot
E-mail: m.loskot@chello.pl
GG#: 792434
