Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291834AbSBXX3H>; Sun, 24 Feb 2002 18:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291840AbSBXX2q>; Sun, 24 Feb 2002 18:28:46 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:2569 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S291834AbSBXX2a>;
	Sun, 24 Feb 2002 18:28:30 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15481.30370.4736.793688@argo.ozlabs.ibm.com>
Date: Mon, 25 Feb 2002 10:26:26 +1100 (EST)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Troy Benjegerdes <hozer@drgw.net>, "David S. Miller" <davem@redhat.com>,
        dalecki@evision-ventures.com, torvalds@transmeta.com,
        andre@linuxdiskcert.org, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <20020225000231.B2590@ucw.cz>
In-Reply-To: <20020224231002.B2199@ucw.cz>
	<15481.26697.420856.1109@argo.ozlabs.ibm.com>
	<20020224233937.B2257@ucw.cz>
	<20020224.144423.104049454.davem@redhat.com>
	<20020224235113.B2412@ucw.cz>
	<20020224165937.I1682@altus.drgw.net>
	<20020225000231.B2590@ucw.cz>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:

> I'd guess most hotpluggable PCIs will have a bridge per slot ...
> hopefully.

That is certainly the case on all the IBM pSeries (RS/6000) machines
with hot-plug PCI that I know of.

Paul.
