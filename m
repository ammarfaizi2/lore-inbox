Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbTGKUhk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbTGKUhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:37:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:912 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265572AbTGKUhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:37:37 -0400
Date: Fri, 11 Jul 2003 17:49:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre3
In-Reply-To: <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
 <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva>
 <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02> <1057703020.5568.10.camel@dhcp22.swansea.linux.org.uk>
 <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307091428450.26373@freak.distro.conectiva>
 <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Jul 2003, Jim Gifford wrote:

> Ok,
>     Here is what I got from my check. Snort is the culprit. When it starts,
> it runs at 40mb. Each hour it adds 20 mb. So by the time the system is up
> for hours, it starts cosuming memory. Today after I restartd my system, I
> noticed every hour it was adding a mb of RAM.
>
> It started at 40mb and after 4 hours is up to 45mb.
>
> Thanx all for your help and assistance.

Ok, thanks for your report.

Try -pre5 8)
