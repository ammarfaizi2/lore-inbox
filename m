Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135672AbREBRhG>; Wed, 2 May 2001 13:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135673AbREBRgz>; Wed, 2 May 2001 13:36:55 -0400
Received: from anime.net ([63.172.78.150]:38663 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S135672AbREBRgl>;
	Wed, 2 May 2001 13:36:41 -0400
Date: Wed, 2 May 2001 10:36:27 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Seth Goldberg <bergsoft@home.com>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <3AEF6F71.A75D478F@home.com>
Message-ID: <Pine.LNX.4.30.0105021035580.18489-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Seth Goldberg wrote:
> > >   The other thing i was gunna try is to dump my chipset registers using
> > > WPCREDIT and WPCRSET and compare them with other people on this list
> > why resort to silly windows tools, when lspci under Linux does it for you?
>   Because lspci does not display all 256 bytes of pci configuration
> information.

Say what?

Try lspci -vvxxx

-Dan

