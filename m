Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbSKCMuL>; Sun, 3 Nov 2002 07:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSKCMuL>; Sun, 3 Nov 2002 07:50:11 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:35077 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261848AbSKCMuK>; Sun, 3 Nov 2002 07:50:10 -0500
Date: Sun, 3 Nov 2002 12:56:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021103125639.A22450@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	=?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021103030909.A11401@infradead.org> <Pine.GSO.4.21.0211031045090.12527-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0211031045090.12527-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Sun, Nov 03, 2002 at 10:47:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 10:47:05AM +0100, Geert Uytterhoeven wrote:
> Just call it kguiconfig. Since /usr/bin/kguiconfig would be a symbolic link to
> /etc/alternatives/kguiconfig on a Debian system, the sysadmin can choose which
> of the zillion different available GUI kernel config programs you'll actually
> run.

Yeah, use kguiconfig for alternatives on debian and let everyone just
directly call $RANDOMONFIGPROGGI :)

