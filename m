Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274909AbRIXTcT>; Mon, 24 Sep 2001 15:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274907AbRIXTcI>; Mon, 24 Sep 2001 15:32:08 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:1310 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274908AbRIXTb5>; Mon, 24 Sep 2001 15:31:57 -0400
Subject: Re: Tritech ???
From: Robert Love <rml@ufl.edu>
To: "[A]ndy80" <andy80@ptlug.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1001360061.1047.11.camel@piccoli>
In-Reply-To: <1001360061.1047.11.camel@piccoli>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 24 Sep 2001 15:32:17 -0400
Message-Id: <1001359940.12894.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-24 at 15:34, [A]ndy80 wrote:
> I ONLY enable EMU10K1 but, during boot I see:
>
> Creative EMU10K1 PCI Audio Driver, version 0.15, 20:31:39 Sep 24 2001
> PCI: Found IRQ 10 for device 00:11.0
> emu10k1: EMU10K1 rev 6 model 0x8027 found, IO at 0xe000-0xe01f, IRQ 10
> ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)
>
> why does kernel load that module?

It doesn't, that is what the AC97 is identifying your mixer as. It's
harmless.  It may even be right.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

