Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270447AbTGSD3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 23:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270488AbTGSD3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 23:29:08 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:31878 "EHLO server")
	by vger.kernel.org with ESMTP id S270447AbTGSD3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 23:29:01 -0400
Message-ID: <000601c34da7$e71954a0$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>   <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva> <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva> <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva> <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva> <00fd01c34c8d$a03a4960$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307171545460.1789@freak.distro.c onectiva> <014501c34c9b$d93d4920$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307171649340.2003@freak.distro.c onectiva> <01d701c34cc0$7f698740$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307180925580.6642@freak.dis tro.conectiva> <002e01c34d41$687dbe30$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307181421550.7889@freak.distro.conectiva> <courier.3F18518C.00003D85@server> <1058565666.19511.93.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: 2.4.22-pre6 deadlock
Date: Fri, 18 Jul 2003 15:51:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Jim Gifford" <maillist@jg555.com>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>; "lkml"
<linux-kernel@vger.kernel.org>
Sent: Friday, July 18, 2003 3:01 PM
Subject: Re: 2.4.22-pre6 deadlock


> On Gwe, 2003-07-18 at 20:59, Jim Gifford wrote:
> > It is part of the antivirus program, information is available here.
> >
> > http://www.dazuko.org
>
> What a fascinating little toy. This ties in with some interesting
> desktop project stuff rather nicely (rememberance agents, live indexing)
>
> However can you duplicate the hang without it loaded ?
>
>
Yes, I can unfortunatly. I just started using the version of Clam Antivirus
that uses it about 2 weeks ago, I thought the problem was virus related at
first. I can disable it with no problems, it's really simple. That was
before I started posting and asking stupid question on lkml.

