Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289908AbSAWQ6j>; Wed, 23 Jan 2002 11:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289911AbSAWQ63>; Wed, 23 Jan 2002 11:58:29 -0500
Received: from skunk.directfb.org ([212.84.236.169]:26318 "EHLO
	skunk.convergence.de") by vger.kernel.org with ESMTP
	id <S289908AbSAWQ60>; Wed, 23 Jan 2002 11:58:26 -0500
Date: Wed, 23 Jan 2002 17:57:41 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: Denis Oliver Kropp <dok@directfb.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NeoMagic Framebuffer Driver
Message-ID: <20020123165741.GA30860@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <20020110161922.GA27357@skunk.convergence.de> <20020123132940.GA30417@skunk.convergence.de> <20020123114357.A29331@wierzbowski.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020123114357.A29331@wierzbowski.devel.redhat.com>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bill Nottingham (notting@redhat.com):
> Denis Oliver Kropp (dok@directfb.org) said: 
> > this version has a MODULE_LICENSE, applies fine to linux-2.4.18-pre6.
> 
> This seems to react rather badly when loaded from within X; I managed
> to lock the machine trying to switch VCs after doing so (for example,
> when I tried with matroxfb, it only screwed up the display.)

The Matrox graphics cards are quite resistant when being programmed
by two drivers simultaneously.

> Yes, I know this falls into the 'don't *DO* that' category. :)

Definitely ;)

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

           convergence integrated media GmbH
