Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289581AbSAXTrS>; Thu, 24 Jan 2002 14:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289677AbSAXTrI>; Thu, 24 Jan 2002 14:47:08 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:46858 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289581AbSAXTrD>;
	Thu, 24 Jan 2002 14:47:03 -0500
Date: Thu, 24 Jan 2002 17:47:30 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020124194729.GD23801@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com> <a2pn9e$mt5$1@cesium.transmeta.com> <20020124193437.GC23801@conectiva.com.br> <3C5063F4.4050103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5063F4.4050103@zytor.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 24, 2002 at 11:43:48AM -0800, H. Peter Anvin escreveu:
> Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jan 24, 2002 at 11:28:46AM -0800, H. Peter Anvin escreveu:
> >>Noone is actually meant to use _Bool, except perhaps in header files.
> >>#include <stdbool.h>
> >   
> > perhaps we don't need another header, adding this instead to types.h.
> 
> That's fine for the Linux kernel, of course, but the above was mostly for
> reference -- it's the *intended* way to use these keywords (you have to
> explicitly import these macros into the namespace, but using the
> C++-compatible tokens is definitely the intention.)

makes sense, I was just thinking about the kernel

- Arnaldo

