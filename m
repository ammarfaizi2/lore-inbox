Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263122AbSJGPkQ>; Mon, 7 Oct 2002 11:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263123AbSJGPkP>; Mon, 7 Oct 2002 11:40:15 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:29736 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S263122AbSJGPjP>;
	Mon, 7 Oct 2002 11:39:15 -0400
From: <Hell.Surfers@cwctv.net>
To: rtomek@cis.com.pl, linux-kernel@vger.kernel.org, rtomek@cis.com.pl
Date: Mon, 7 Oct 2002 16:44:39 +0100
Subject: RE:Re: v.34 rockwell support in 2.4.**
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034005479364"
Message-ID: <06ad129421507a2DTVMAIL4@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034005479364
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

No, I think I know the difference, the kernel IS supposed to support hardware modems, as for winmodems, ive written a HSP to help port them, which if anybody wants, mail me, i'll set up a sourceforge site for it soon.

Cheers, Dean.

On 	Mon, 7 Oct 2002 17:18:39 +0200 (CEST) 	Tomasz Rola <rtomek@cis.com.pl> wrote:

--1034005479364
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Mon, 7 Oct 2002 16:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263075AbSJGPIz>; Mon, 7 Oct 2002 11:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263076AbSJGPIz>; Mon, 7 Oct 2002 11:08:55 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:25232 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S263075AbSJGPIw>;
	Mon, 7 Oct 2002 11:08:52 -0400
Received: from saturn.space.nemesis.pl ([10.0.1.1] helo=pioneer)
	by pioneer with smtp (Exim 3.35 #1 (Debian))
	id 17yZeg-0001ts-00; Mon, 07 Oct 2002 17:18:46 +0200
Date: Mon, 7 Oct 2002 17:18:39 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
X-Sender: tomek@pioneer
To: Hell.Surfers@cwctv.net
cc: linux-kernel@vger.kernel.org, Tomasz Rola <rtomek@cis.com.pl>
Subject: Re: v.34 rockwell support in 2.4.**
In-Reply-To: <0657941351107a2DTVMAIL11@smtp.cwctv.net>
Message-ID: <Pine.LNX.3.96.1021007165819.2747B-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 7 Oct 2002 Hell.Surfers@cwctv.net wrote:

> Where in the kernel is 33.6 enhanced support? Basic Rockwell support for
> it seems to be missing.

Let me guess - do you have a so called 'winmodem'? Then perhaps you should
read this:

http://www.linmodems.org/

http://www.iac.es/galeria/eddie/linux/modem/winmodem.html

Otherwise, if your modem claims to support v34 then it should be able to
do this by itself. IMHO, the kernel's most important task is to make
serial ports available to communication programs, not to implement
protocols (especially when manufacturers won't give specifications to
people wanting to port them to Linux).

You can also try this:

http://www.56k.com/

I'm not sure if this is the answer to your question.

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBPaGl1hETUsyL9vbiEQIvWACg9apZgii53utRqQ5Oa9evvmVsBfQAn3Be
3VihAdRbZZpGGUfJmDlY2fat
=J2JV
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034005479364--


