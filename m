Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSGTELy>; Sat, 20 Jul 2002 00:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317348AbSGTELy>; Sat, 20 Jul 2002 00:11:54 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:39176 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317347AbSGTELx>; Sat, 20 Jul 2002 00:11:53 -0400
Date: Sat, 20 Jul 2002 01:14:51 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
Message-ID: <20020720041451.GD4557@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207192224280.1120-100000@waste.org> <200207192308.54936.kelledin+LKML@skarpsey.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207192308.54936.kelledin+LKML@skarpsey.dyndns.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 19, 2002 at 11:08:54PM -0500, Kelledin escreveu:
> I agree, the lm_sensors driver should maintain a blacklist for 
> ThinkPads, and make it possible to disable the blacklist only by 
> going in and hacking the kernel source manually.  Whenever the 
> lm_sensors drivers detect a blacklisted ThinkPad, they should 
> vehemently refuse to function.

If they can detect that the machine is a ThinkPad, that is a great idea.

- Arnaldo
