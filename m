Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRCAQue>; Thu, 1 Mar 2001 11:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129723AbRCAQuY>; Thu, 1 Mar 2001 11:50:24 -0500
Received: from mehl.gfz-potsdam.de ([139.17.1.100]:13013 "EHLO
	mehl.gfz-potsdam.de") by vger.kernel.org with ESMTP
	id <S129712AbRCAQuT> convert rfc822-to-8bit; Thu, 1 Mar 2001 11:50:19 -0500
Date: Thu, 1 Mar 2001 17:50:04 +0100
From: Steffen Grunewald <steffen@gfz-potsdam.de>
To: linux-kernel@vger.kernel.org
Cc: Tim Walberg <tewalberg@mediaone.net>
Subject: Re: smartmedia adapter support??
Message-ID: <20010301175002.H7883@dss19>
Mail-Followup-To: Steffen Grunewald <steffen>, linux-kernel@vger.kernel.org,
	Tim Walberg <tewalberg@mediaone.net>
In-Reply-To: <20010301100041.A22824@mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010301100041.A22824@mediaone.net>; from tewalberg@mediaone.net on Thu, Mar 01, 2001 at 10:00:41AM -0600
X-Disclaimer: I don't speak for no one else. And vice versa
X-Operating-System: SunOS
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by dss19.gfz-potsdam.de id RAA14680
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2001-03-01 (10:00), Tim Walberg wrote:
> Just wondering whether anyone has successfully gotten
> either a PCMCIA SmartMedia Adapter (specifically the
> Viking Components one) or a FlashPath floppy SmartMedia
> adapter working under 2.4.x. I've got both, and haven't
> gotten either working under either 2.2.x or 2.4.x, but
> I haven't had the time to work real hard at it either,
> so I'm hoping someone can give me some pointers...

http://www.smartdisk.com has a driver (which includes a binary-
only library) for FlashPath that you can compile for your kernel

Works fine here (2.2.16)

Don't know about PCMCIA though

Steffen
-- 
Steffen Grunewald | GFZ | PB 2.2 | Telegrafenberg E3 | D-14473 Potsdam
» email: steffen(at)gfz-potsdam.de | fax/fon: +49-331-288-1266/-1245 «
Software is like sex - it's better when it's free. --- Linus Torvalds
