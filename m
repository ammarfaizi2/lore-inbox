Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272265AbTGYTZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272266AbTGYTZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:25:04 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:62342 "EHLO server")
	by vger.kernel.org with ESMTP id S272265AbTGYTZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:25:02 -0400
Message-ID: <01f001c352e4$9025e6d0$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "Andrea Arcangeli" <andrea@suse.de>, "lkml" <linux-kernel@vger.kernel.org>,
       "Marc Heckmann" <mh@nadir.org>
References: <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva> <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva> <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva> <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva> <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva> <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02> <20030719172103.GA1971@x30.local> <018101c34f4d$430d5850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307210943160.25565@freak.distro.conectiva> <005a01c34fed$fea51120$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307220852470.10991@freak.distro.conectiva> <012d01c35066$2c56d400$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307221358440.23424@freak.distro.conectiva>
Subject: Re: 2.4.22-pre5 deadlock
Date: Fri, 25 Jul 2003 12:40:11 -0700
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

>From talking with others, we are considering this a netfilter issue, is this
correct??

