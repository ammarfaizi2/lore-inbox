Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275881AbSIUEZi>; Sat, 21 Sep 2002 00:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275882AbSIUEZi>; Sat, 21 Sep 2002 00:25:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:5536 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S275881AbSIUEZi>; Sat, 21 Sep 2002 00:25:38 -0400
Date: Sat, 21 Sep 2002 01:12:20 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Zach Brown <zab@zabbo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list_head debugging?
Message-ID: <20020921041220.GB16027@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org
References: <20020920165304.A4588@bitchcake.off.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920165304.A4588@bitchcake.off.net>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 20, 2002 at 04:53:04PM -0400, Zach Brown escreveu:
> A friend recently was bitten by passing a list_head from list_for_each
> to a code path that later moved the list_head around.  Does the attached
> patch re-create some debugging wheel that's hiding off in a corner
> somewhere?

Cool! I'll be always using this while developing, thanks!

- Arnaldo
