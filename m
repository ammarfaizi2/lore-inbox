Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSJHJc0>; Tue, 8 Oct 2002 05:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbSJHJc0>; Tue, 8 Oct 2002 05:32:26 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:64819 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S261599AbSJHJcY>;
	Tue, 8 Oct 2002 05:32:24 -0400
From: <Hell.Surfers@cwctv.net>
To: landley@trommello.org, porter@cox.net, davem@redhat.com, giduru@yahoo.com,
       andre@linux-ide.org, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 10:36:21 +0100
Subject: Re: The end of embedded Linux?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034069781264"
Message-ID: <06d8659340908a2DTVMAIL12@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034069781264
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Integral support for TinyX would be nice(www.handhelds.org).

Cheers, Dean.

On 	Mon, 7 Oct 2002 15:50:43 -0400 	Rob Landley <landley@trommello.org> wrote:

--1034069781264
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Tue, 8 Oct 2002 03:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbSJHC3u>; Mon, 7 Oct 2002 22:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262683AbSJHC3u>; Mon, 7 Oct 2002 22:29:50 -0400
Received: from pc132.utati.net ([216.143.22.132]:53921 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262674AbSJHC3t>; Mon, 7 Oct 2002 22:29:49 -0400
Received: from there (pc141.utati.net [216.143.22.141])
	by merlin.webofficenow.com (Postfix on SuSE Linux 7.2 (i386)) with SMTP
	id C0DDF630; Mon,  7 Oct 2002 19:50:30 -0500 (CDT)
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Matt Porter <porter@cox.net>
Subject: Re: The end of embedded Linux?
Date: Mon, 7 Oct 2002 15:50:43 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "David S. Miller" <davem@redhat.com>, giduru@yahoo.com,
	andre@linux-ide.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021007214053.36F16622@merlin.webofficenow.com> <20021007162048.A19216@home.com>
In-Reply-To: <20021007162048.A19216@home.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021008005030.C0DDF630@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Monday 07 October 2002 07:20 pm, Matt Porter wrote:
>
> > Or they could play in the source code if their needs are sufficiently
> > unusual, which more or less by definition they will be in this case.  No
> > matter how thorough you are here, there will be things they want to tweak
> > (or would if they knew about them) that there is no config option for. 
> > "make menuconfig" is not a complete replacement for knowing C in all
> > cases.
>
> True, but there are a number of people out there who want to do say
> a kernel port to XYZ custom board.  They learn some basic kernel
> knowledge, but we can't expect them to be a guru of everything to
> get some work done.

Another very real option here is Documentation/tinykernel.txt.  (Possibly 
even going so far as a brief mention of uclibc and busybox/tinylogin, but 
mostly just about choping down the kernel for embedding in nosehair trimmers 
and electric toothbrushes and such.)

Rob "waiting for the linux i-button" Landley.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034069781264--


