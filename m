Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270816AbTGVLoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270817AbTGVLoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:44:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62418 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270816AbTGVLoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:44:03 -0400
Date: Tue, 22 Jul 2003 08:53:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre5 deadlock
In-Reply-To: <005a01c34fed$fea51120$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307220852470.10991@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
 <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02> <20030719172103.GA1971@x30.local>
 <018101c34f4d$430d5850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307210943160.25565@freak.distro.conectiva>
 <005a01c34fed$fea51120$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jul 2003, Jim Gifford wrote:

> > Lets wait and see what happens without the iptables and dazuko modules.
> >
> Marcelo,
>     -pre7 seems to be working ok. Do you want me to enable the dazuko thing
> again to see if it's the cause, or do you want me to wait a little longer to
> see what happens.

Jim,

I prefer if you leave -pre7 running for a while to confirm its stable.


