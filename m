Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSKSRUg>; Tue, 19 Nov 2002 12:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSKSRUg>; Tue, 19 Nov 2002 12:20:36 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:10404 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265132AbSKSRUf> convert rfc822-to-8bit; Tue, 19 Nov 2002 12:20:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "Folkert van Heusden" <folkert@vanheusden.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: local link configuration daemon?
Date: Tue, 19 Nov 2002 18:27:10 +0100
User-Agent: KMail/1.4.3
References: <003b01c28fed$724a2c80$3640a8c0@boemboem>
In-Reply-To: <003b01c28fed$724a2c80$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211191827.10622.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 19. November 2002 18:02 schrieb Folkert van Heusden:
> Hi,
>
> I just read this RFC on 'local link configuration' (mirrored at
> http://keetweej.vanheusden.com/~folkert/draft-ietf-zeroconf-ipv4-linklocal.
>t xt ) and I was wondering: is this planned to be in the kernel? Or should
> occur this in userspace? (and if so; does it exist? freshmeat/google say it
> doesn't)
> Initially I thought I just configure an ip-address in that range on an
> adapter, but then I read that there is this whole protocol of sending and
> receiving arp-requests etc.

Brad Hards has done a preliminary implementation that runs in user space.

	HTH
		Oliver

