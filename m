Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbTGQTaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268736AbTGQTaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:30:13 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:1922 "EHLO server")
	by vger.kernel.org with ESMTP id S268177AbTGQTaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:30:11 -0400
Message-ID: <014501c34c9b$d93d4920$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva> <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02> <1057703020.5568.10.camel@dhcp22.swansea.linux.org.uk> <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307091428450.26373@freak.distro.conectiva> <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva> <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva> <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva> <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva> <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva> <00fd01c34c8d$a03a4960$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307171545460.1789@freak.distro.conectiva>
Subject: Re: 2.4.22-pre6 deadlock
Date: Thu, 17 Jul 2003 12:44:33 -0700
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
From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
To: "Jim Gifford" <maillist@jg555.com>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Sent: Thursday, July 17, 2003 11:46 AM
Subject: Re: 2.4.22-pre6 deadlock


>
> Jim,
>
> I just noticed your kernel is tained.
>
> For what reason?
>
>

The only patches I use are for netfilter options and the updated megaraid
driver everything else is stock.

Do you think some of the netfilter options could be causing the problems??

