Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbSJGWy3>; Mon, 7 Oct 2002 18:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbSJGWyX>; Mon, 7 Oct 2002 18:54:23 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1730 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262705AbSJGWxw>; Mon, 7 Oct 2002 18:53:52 -0400
Date: Mon, 7 Oct 2002 19:59:27 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: simon@baydel.com
Cc: Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007225927.GH3485@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	simon@baydel.com, Xavier Bestel <xavier.bestel@free.fr>,
	linux-kernel@vger.kernel.org
References: <3DA16A9B.7624.4B0397@localhost> <3DA1D07E.10994.142437C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA1D07E.10994.142437C@localhost>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 07, 2002 at 06:20:46PM +0100, simon@baydel.com escreveu:
> It is likley that this project will not go to the market with Linux as 
> the OS. The original intention was to make available all kernel 
> changes and ship object modules for the specialised hardware. 
> 
> Reading the GPL tells me that really it is not correct to ship 
> modules either, athough I know people do it.

Well, ask a lawyer, but Linux is licensed under the GPL _plus_ some
extra clauses, for instance it is ok, AFAIK, to ship a binary only module
that restrains itself to using non EXPORT_SYMBOL_GPL exported symbols.

Think NVidia, vmware, etc.

And yes, IANAL.

- Arnaldo
