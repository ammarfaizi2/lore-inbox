Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSGJOfa>; Wed, 10 Jul 2002 10:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSGJOf3>; Wed, 10 Jul 2002 10:35:29 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:29701 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317392AbSGJOf0>; Wed, 10 Jul 2002 10:35:26 -0400
Date: Wed, 10 Jul 2002 15:38:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: Vitaly Fertman <vitaly@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: reiserfsprogs release
Message-ID: <20020710153801.A8570@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Cole <elenstev@mesatop.com>,
	Vitaly Fertman <vitaly@namesys.com>, reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <200206251829.25799.vitaly@namesys.com> <20020625165254.GA30301@matrix.wg> <200206261317.10813.vitaly@namesys.com> <200207101206.48370.vitaly@namesys.com> <1026311034.7074.76.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1026311034.7074.76.camel@spc9.esa.lanl.gov>; from elenstev@mesatop.com on Wed, Jul 10, 2002 at 08:23:54AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 08:23:54AM -0600, Steven Cole wrote:
> On Wed, 2002-07-10 at 02:06, Vitaly Fertman wrote:
> > 
> > Hi all,
> > 
> > the latest reiserfsprogs-3.6.2 is available on our ftp site.
> > 
> 
> Is the following patch to Documentation/Changes appropriate?

Does reiserfs in 2.4.19-pre require that version?  if yes it would be
very bad (2.4 is not supposed to need newer userlevel during the series)

