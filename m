Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSHDC0A>; Sat, 3 Aug 2002 22:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318073AbSHDCZ7>; Sat, 3 Aug 2002 22:25:59 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:45858 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S318067AbSHDCZ7>;
	Sat, 3 Aug 2002 22:25:59 -0400
From: <Hell.Surfers@cwctv.net>
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Date: Sun, 4 Aug 2002 03:29:06 +0100
Subject: AT commands & V. Standards. Anyone can be of help..
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1028428146828"
Message-ID: <0aa163928020482DTVMAIL9@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1028428146828
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Further to your mail message I believe anyone could be helpful, I need information on hayes modem at functions ,in depth info on how they work, and v. standards literature, any in depth informations in pdf, any format, even if its vague, give me any info you have... anyone who thinks they know anything SHOULD TELL ME... PLEASE.



On Fri, 02 Aug 2002 21:49:00 -0400 Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

--1028428146828
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from www.linux.org.uk ([195.92.249.252]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Sat, 3 Aug 2002 02:48:41 +0100
Received: from adsl-154-25-35.asm.bellsouth.net ([68.154.25.35] helo=mandrakesoft.com)
	by www.linux.org.uk with esmtp (Exim 3.33 #5)
	id 17ao2P-0007ut-00
	for Hell.Surfers@cwctv.net; Sat, 03 Aug 2002 02:49:01 +0100
Message-ID: <3D4B368C.8010302@mandrakesoft.com>
Date: Fri, 02 Aug 2002 21:49:00 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hell.Surfers@cwctv.net
Subject: Re: how do i integrate my winmodem driver.
References: <0c9012035010382DTVMAIL4@smtp.cwctv.net>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: jgarzik@mandrakesoft.com

Hell.Surfers@cwctv.net wrote:
> so far ive got io with the modem and very#very# basic signal processing i unfortunately am not au fais with v.90 ortcp/ip....


drivers/char/mxser.c seems like a good example to follow, for a basic 
serial driver...

Let me know if you have any specific questions I can answer, I am very 
interested in getting winmodem support going.  I'm willing to review 
code, as well, when you have something close to working under Linux.

	Jeff




--1028428146828--


