Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317437AbSGJOpC>; Wed, 10 Jul 2002 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317439AbSGJOpC>; Wed, 10 Jul 2002 10:45:02 -0400
Received: from angband.namesys.com ([212.16.7.85]:4224 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317437AbSGJOpA>; Wed, 10 Jul 2002 10:45:00 -0400
Date: Wed, 10 Jul 2002 18:47:44 +0400
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@infradead.org>, Steven Cole <elenstev@mesatop.com>,
       Vitaly Fertman <vitaly@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [reiserfs-list] Re: reiserfsprogs release
Message-ID: <20020710184744.A1939@namesys.com>
References: <200206251829.25799.vitaly@namesys.com> <20020625165254.GA30301@matrix.wg> <200206261317.10813.vitaly@namesys.com> <200207101206.48370.vitaly@namesys.com> <1026311034.7074.76.camel@spc9.esa.lanl.gov> <20020710153801.A8570@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020710153801.A8570@infradead.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 10, 2002 at 03:38:01PM +0100, Christoph Hellwig wrote:

> > > the latest reiserfsprogs-3.6.2 is available on our ftp site.
> > Is the following patch to Documentation/Changes appropriate?

> Does reiserfs in 2.4.19-pre require that version?  if yes it would be

No.

> very bad (2.4 is not supposed to need newer userlevel during the series)

Well, sometimes you want to upgrade not because it is required, but because
of bugfixed you will get out of newer version.

Bye,
    Oleg
