Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSGJO3G>; Wed, 10 Jul 2002 10:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSGJO3F>; Wed, 10 Jul 2002 10:29:05 -0400
Received: from angband.namesys.com ([212.16.7.85]:3968 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317354AbSGJO3E>; Wed, 10 Jul 2002 10:29:04 -0400
Date: Wed, 10 Jul 2002 18:31:48 +0400
From: Oleg Drokin <green@namesys.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Vitaly Fertman <vitaly@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [reiserfs-list] Re: reiserfsprogs release
Message-ID: <20020710183147.A1749@namesys.com>
References: <200206251829.25799.vitaly@namesys.com> <20020625165254.GA30301@matrix.wg> <200206261317.10813.vitaly@namesys.com> <200207101206.48370.vitaly@namesys.com> <1026311034.7074.76.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1026311034.7074.76.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 10, 2002 at 08:23:54AM -0600, Steven Cole wrote:

> > the latest reiserfsprogs-3.6.2 is available on our ftp site.
> Is the following patch to Documentation/Changes appropriate?
> -o  reiserfsprogs          3.x.1b                  # reiserfsck 2>&1|grep reiserfsprogs
> +o  reiserfsprogs          3.6.2                   # reiserfsck 2>&1|grep reiserfsprogs

Not yet. We do not want to disturb Marchello with more patches now.
We will submit similar patch after 2.4.19 is out.

Bye,
    Oleg
