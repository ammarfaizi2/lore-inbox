Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSIEUKq>; Thu, 5 Sep 2002 16:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSIEUKq>; Thu, 5 Sep 2002 16:10:46 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:53511 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318136AbSIEUKp>; Thu, 5 Sep 2002 16:10:45 -0400
Date: Thu, 5 Sep 2002 21:15:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, paulkf@microgate.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix .text.exit error with static compile of synclinkmp.c
Message-ID: <20020905211517.A15616@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, paulkf@microgate.com,
	linux-kernel@vger.kernel.org
References: <20020905184359.A9907@infradead.org> <Pine.NEB.4.44.0209052147500.7218-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.NEB.4.44.0209052147500.7218-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Thu, Sep 05, 2002 at 10:11:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 10:11:27PM +0200, Adrian Bunk wrote:
> Yes, that sounds like a better idea. What about the following patch?

Looks good to me.

