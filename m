Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318373AbSGRWRp>; Thu, 18 Jul 2002 18:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318374AbSGRWRp>; Thu, 18 Jul 2002 18:17:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57103 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318373AbSGRWRo>; Thu, 18 Jul 2002 18:17:44 -0400
Date: Thu, 18 Jul 2002 19:20:26 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: willy@debian.org, jsimmons@transvirtual.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 broken on headless boxes
Message-ID: <20020718222026.GH2740@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, willy@debian.org,
	jsimmons@transvirtual.com, linux-kernel@vger.kernel.org
References: <20020718221619.GA16292@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718221619.GA16292@vana.vc.cvut.cz>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 19, 2002 at 12:16:19AM +0200, Petr Vandrovec escreveu:
> so we did not registered VT subsystem and panic did not happened:
> instead of that you got 'cannot open initial console' or something
> like that...

Hummm, maybe this is what was biting me yesterday... I'll check RSN,
as soon as I arrive at home 8)

- Arnaldo
