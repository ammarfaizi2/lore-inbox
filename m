Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbTGLGMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 02:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTGLGMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 02:12:36 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:50436 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264689AbTGLGMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 02:12:36 -0400
Date: Sat, 12 Jul 2003 07:27:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5
Message-ID: <20030712072713.A1219@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jeff Garzik <jgarzik@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva> <shsu19siyru.fsf@charged.uio.no> <Pine.LNX.4.55L.0307111752060.5537@freak.distro.conectiva> <16143.10146.718830.585351@charged.uio.no> <Pine.LNX.4.55L.0307111853540.5883@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.55L.0307111853540.5883@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jul 11, 2003 at 06:56:16PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 06:56:16PM -0300, Marcelo Tosatti wrote:
> Well, Jeff, Christoph, do you have any comments on Trond's new
> O_DIRECT patch?

Patch looks fine.  I don't really like the directfileio name, but
hey, this cludge is so ugly that it doesn't really matter anymore..

