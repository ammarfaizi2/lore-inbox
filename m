Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSHFVml>; Tue, 6 Aug 2002 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSHFVml>; Tue, 6 Aug 2002 17:42:41 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:49681 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315784AbSHFVmi>;
	Tue, 6 Aug 2002 17:42:38 -0400
Date: Tue, 6 Aug 2002 14:43:35 -0700
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] : ir240_usb_disconnect-2.diff
Message-ID: <20020806214334.GA2393@kroah.com>
References: <20020806205251.GF11677@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020806205251.GF11677@bougret.hpl.hp.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 09 Jul 2002 20:23:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 01:52:51PM -0700, Jean Tourrilhes wrote:
>  	purb_t purb;

I've gotten rid of this stupid typedef in Marcelo's latest kernel, so
this patch will probably not apply.

Sorry about this.  If it's a big problem, I'll do the merge for you.

thanks,

greg k-h
