Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270230AbTGRMQD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271596AbTGRMQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:16:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12172 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270230AbTGRMQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:16:00 -0400
Date: Fri, 18 Jul 2003 09:26:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre6 deadlock
In-Reply-To: <01d701c34cc0$7f698740$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307180925580.6642@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
 <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307091428450.26373@freak.distro.conectiva>
 <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
 <00fd01c34c8d$a03a4960$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307171545460.1789@freak.distro.c
 onectiva> <014501c34c9b$d93d4920$3400a8c0@W2RZ8L4S02>
 <Pine.LNX.4.55L.0307171649340.2003@freak.distro.c onectiva>
 <01d701c34cc0$7f698740$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, please.

I'll investigate yours and Stephan more carefully today.

On Thu, 17 Jul 2003, Jim Gifford wrote:

> If it acts up again, do you want a copy of the build logs??
>
