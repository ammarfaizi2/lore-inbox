Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRKMMcT>; Tue, 13 Nov 2001 07:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279064AbRKMMcJ>; Tue, 13 Nov 2001 07:32:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60936 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276369AbRKMMb4>; Tue, 13 Nov 2001 07:31:56 -0500
Subject: Re: via82cxxx_audio problems
To: marcelo@datacom-telematica.com.br (Marcelo Borges Ribeiro)
Date: Tue, 13 Nov 2001 12:39:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004601c16c3c$8f865e70$1300a8c0@marcelo> from "Marcelo Borges Ribeiro" at Nov 13, 2001 10:08:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163cqd-00012s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in dmesg) and cannot play in any other rate. With mplayer you can see
> messages such as requested 16000Hz got (480000) that explains why it so=
> unds
> like chip'n'dale ;-). P.s. I don=B4t know why it works with xmms  but w=
> ith
> mpg123 it refuses to play at all becouse these sound rates.

XMMS does the right thing. It understands how to do rate adaption. 
