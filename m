Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVDGK2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVDGK2m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVDGK2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:28:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35274 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262420AbVDGK2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:28:39 -0400
Date: Thu, 7 Apr 2005 11:28:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Ian Campbell <ijc@hellion.org.uk>, Sven Luther <sven.luther@wanadoo.fr>,
       "Theodore Ts'o" <tytso@mit.edu>, Greg KH <greg@kroah.com>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050407102805.GA9586@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Christoph Hellwig <hch@lst.de>, Ian Campbell <ijc@hellion.org.uk>,
	Sven Luther <sven.luther@wanadoo.fr>, Theodore Ts'o <tytso@mit.edu>,
	Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
	debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
	linux-kernel@vger.kernel.org
References: <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org> <m1wtrfk8w3.fsf@ebiederm.dsl.xmission.com> <4254FEC0.5060708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4254FEC0.5060708@pobox.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 05:34:56AM -0400, Jeff Garzik wrote:
> >For tg3 a transition period shouldn't be needed as firmware loading
> >is only needed on old/buggy hardware which is not the common case.
> >Or to support advanced features which can be disabled.
> 
> TSO firmware is commonly used these days.

Because our TSO support has been totally broken for a long time?

