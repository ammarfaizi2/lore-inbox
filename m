Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTAOTU3>; Wed, 15 Jan 2003 14:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTAOTU3>; Wed, 15 Jan 2003 14:20:29 -0500
Received: from [66.70.28.20] ([66.70.28.20]:61702 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266987AbTAOTU1>; Wed, 15 Jan 2003 14:20:27 -0500
Date: Wed, 15 Jan 2003 20:19:42 +0100
From: DervishD <raul@pleyades.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: argv0 revisited...
Message-ID: <20030115191942.GD47@DervishD>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA88@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CACA88@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Iñaki :)

> > of init. Remember, is not any program, is an init. Should be a more
> > clean way, I suppose :??
> I don't think is that big a deal ... if you startup the system normally,
> sooner or later, /proc is going to be mounted. A [quickie] variation is:

    Yes, I know, and that's one option, but I would like to avoid the
mounting. Not a big deal, anyway, as you say. The only thing is that
it won't work in kernels without proc enabled (yes, there are people
without 'proc', size issues, I suppose, etc...).

    Thanks a lot :)
    Raúl
