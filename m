Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267793AbTGHWdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbTGHWda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:33:30 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:4481 "EHLO server")
	by vger.kernel.org with ESMTP id S267793AbTGHWcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:32:16 -0400
Message-ID: <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva> <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02> <1057703020.5568.10.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: Linux 2.4.22-pre3
Date: Tue, 8 Jul 2003 15:46:44 -0700
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
Sent: Tuesday, July 08, 2003 3:23 PM
Subject: Re: Linux 2.4.22-pre3


> On Maw, 2003-07-08 at 22:36, Jim Gifford wrote:
> > Server is a multi-purpose box. Apache, Courier Mail, Proftp, and SSH.
(ran
> > on version 2.4.19 with no issues, problems started with 2.4.20.)
> >
> > Compiled using GCC 3.3.
>
> So the problem started before you switched compilers you were using to
> build kernels ?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
The problem was also pre GCC 3.3. I also have tried to compile the kernel
with GCC 2.95.3 I still get lock ups also.

