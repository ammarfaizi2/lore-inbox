Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274766AbRJNHxP>; Sun, 14 Oct 2001 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRJNHwz>; Sun, 14 Oct 2001 03:52:55 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:9344 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S274746AbRJNHwu>; Sun, 14 Oct 2001 03:52:50 -0400
Message-ID: <3BC9446D.A47CE2C6@welho.com>
Date: Sun, 14 Oct 2001 10:53:17 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <3BC8DAF0.3D16A546@welho.com>
		<20011013.234016.104032175.davem@redhat.com>
		<3BC9393D.765A156@welho.com> <20011014.005041.39156727.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Mika Liljeberg <Mika.Liljeberg@welho.com>
>    Date: Sun, 14 Oct 2001 10:05:33 +0300
> 
>    Looking at the dump, it seems that most arriving
>    segments have the PSH bit set.
> 
> I know you said what is running on the receiver, but do
> you have any clue what is running on the sender?  It looks
> _really_ broken.
> 
> The transfer looks like a bulk one but every segment (as you have
> stated) has PSH set, which is completely stupid.
> 
> At least, I can guarentee you that the sender is not Linux.  Or,
> if it is Linux, it is running a really broken implementation of
> a web server. :-)

I've got a feeling you're going to rue saying that (see my other email).
;-)

Regards,

	MikaL
