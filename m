Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSA2F7F>; Tue, 29 Jan 2002 00:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSA2F6z>; Tue, 29 Jan 2002 00:58:55 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:33230 "EHLO fep6.cogeco.net")
	by vger.kernel.org with ESMTP id <S287647AbSA2F6m> convert rfc822-to-8bit;
	Tue, 29 Jan 2002 00:58:42 -0500
Subject: Re: VIA KT266 and SBLive! (emu10k1)
From: "Nix N. Nix" <nix@go-nix.ca>
To: Martin =?iso-8859-2?Q?Ma=E8ok?= <martin.macok@underground.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020127010324.K1409@sarah.kolej.mff.cuni.cz>
In-Reply-To: <1012086718.11336.91.camel@tux> 
	<20020127010324.K1409@sarah.kolej.mff.cuni.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.14.17.03 (Preview Release)
Date: 29 Jan 2002 00:58:37 -0500
Message-Id: <1012283920.16708.1.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> 
> Try changing theese values
> -CONFIG_HIGHMEM4G=y
> +CONFIG_NOHIGHMEM=y
> 
> -CONFIG_SOUND_DMAP=y
> +# CONFIG_SOUND_DMAP is not set

Yep. Seems to work.



Thanks.
> 
> I don't know why ... but it just helped me.
> 
> (and I think that some have also succeded with i686 kernel instead of
> athlon kernel)
> 
> -- 
>          Martin Maèok                 http://underground.cz/
>    martin.macok@underground.cz        http://Xtrmntr.org/ORBman/
> -

