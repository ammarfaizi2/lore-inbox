Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTALVl1>; Sun, 12 Jan 2003 16:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTALVl0>; Sun, 12 Jan 2003 16:41:26 -0500
Received: from vitelus.com ([64.81.243.207]:35600 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S267540AbTALVlZ>;
	Sun, 12 Jan 2003 16:41:25 -0500
Date: Sun, 12 Jan 2003 13:49:37 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Rob Wilkens <robw@optonline.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112214937.GM31238@vitelus.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com> <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 04:44:05PM -0500, Rob Wilkens wrote:
> There's no reason, though, that the error handling/cleanup code can't be
> in an entirely separate function, and if speed is needed, there's no
> reason it can't be an "inline" function.  Or am I oversimplifying things
> again?

Remind me why this is better than a goto?
