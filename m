Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbSAGSst>; Mon, 7 Jan 2002 13:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285118AbSAGSsj>; Mon, 7 Jan 2002 13:48:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63500 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285093AbSAGSsd> convert rfc822-to-8bit; Mon, 7 Jan 2002 13:48:33 -0500
Date: Mon, 7 Jan 2002 10:47:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@ns.caldera.de>,
        Jaroslav Kysela <perex@suse.cz>, <sound-hackers@zabbo.net>,
        <linux-sound@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <3C39EB68.BC8C804@alsa-project.org>
Message-ID: <Pine.LNX.4.33.0201071044260.6694-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g07Im1S01640
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Abramo Bagnara wrote:
>
> Just to resume, you think that the way to go is:
>
> 1) to have sound/ with *all* sound related stuff inside
> 2) to leave drivers/net/ and net/ like they are now (because although
> it's suboptimal, to change it is a mess we don't want to face now)

This is my current feeling.

However, la donna é mobile, and I'm a primus donna, fer shure. So don't
take it _too_ seriously, continue to argue the merits of other approaches.

		Linus

