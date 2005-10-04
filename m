Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVJDNzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVJDNzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVJDNzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:55:12 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:58923 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S932450AbVJDNzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:55:10 -0400
DomainKey-Signature: a=rsa-sha1; b=bbkaeN8SJ92NhNqJLaZ4snGONH8lITAwyYW+btO9pKP0EmVoH+vH62Tn01LxLTGkCq/6bP+m674z9/otTk/Q4s3zA26OYKfGmsu6vB1LtAmmH2NnuZtPbQ/MhhuMtuBq0umCcPHF53HGDWXCn4+I4pnMkhpVa51fvhybIGacdQM=; c=nofws; d=rudy.mif.pg.gda.pl; q=dns; s=prime
Date: Tue, 4 Oct 2005 15:55:04 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Ryan Anderson <ryan@autoweb.net>, Luben Tuikov <luben_tuikov@adaptec.com>,
       andrew.patterson@hp.com, Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org>
Message-ID: <Pine.BSO.4.62.0510041438100.28198@rudy.mif.pg.gda.pl>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
  <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>
  <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>
  <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com> 
 <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>  <4341381D.2060807@adaptec.com>
  <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl> 
 <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com> 
 <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl>
 <1128377075.23932.5.camel@ryan2.internal.autoweb.net>
 <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1798302637-1128432835=:28198"
Content-ID: <Pine.BSO.4.62.0510041534090.28198@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1798302637-1128432835=:28198
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0510041534091.28198@rudy.mif.pg.gda.pl>

On Mon, 3 Oct 2005, Linus Torvalds wrote:
[..]
> This is especially common in the "cheap" market. For example, for SCSI,
> most of the violations tend to be USB storage - which is supposed to act
> largely like SCSI, but in reality really doesn't. It locks up if you
> try to access sectors that aren't there, etc.

Yes .. of course .. but please don't tap some words (without this kind 
comment) which sounds like rules [1]. *Especialy if* talk is about *one* 
specified piece of hardware. Moving discuss from one point to full 
population many people takes as plain trolling. Luben looks like SAS 
specialist and if you drive discuss outside SAS area this must be 
confusing for him .. and not only for him. And also .. SAS controlers 
this is not '"cheap" market'.

[1] look at comments at /. and osnews: 
http://linux.slashdot.org/article.pl?sid=05/10/02/218233&tid=8&tid=106 
http://osnews.com/comment.php?news_id=12074
look how many people without proper knowledge level assumes: Linus is 
authoritet -> Linus says "spec is close to useless" (without looking on 
context) -> .. probaly spec is realy useless. Of course it is blind 
repeatig but case like this may ruine many thing aroud Linux .. and 
forgive me: you must be aware all this.

Thank You, sorry and regards

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1798302637-1128432835=:28198--
