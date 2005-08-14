Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVHNBkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVHNBkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 21:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVHNBkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 21:40:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25563 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932304AbVHNBkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 21:40:21 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Lee Revell <rlrevell@joe-job.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugo Mills <hugo-lkml@carfax.org.uk>,
       Stephen Pollei <stephen.pollei@gmail.com>,
       "=?ISO-8859-1?Q? Martin_v._L=F6wis ?=" <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <896E8B77-FD22-4898-BFE5-559936B8040E@mac.com>
References: <42FDE286.40707@v.loewis.de>
	 <feed8cdd0508130935622387db@mail.gmail.com>
	 <1123958572.11295.7.camel@mindpipe> <20050813184951.GA8283@carfax.org.uk>
	 <1123959201.11295.9.camel@mindpipe>
	 <1123981065.14138.29.camel@localhost.localdomain>
	 <896E8B77-FD22-4898-BFE5-559936B8040E@mac.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 13 Aug 2005 21:40:18 -0400
Message-Id: <1123983619.17816.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 21:19 -0400, Kyle Moffett wrote:
> And those of us who are Mac OS X oriented have patched our console and
> X keycodes to match the mac way of generating symbols:
> 
> Alt-\        = «
> Alt-Shift-\  = »
> Alt-Shift-+  = ±
> 

My point exactly, it's idiotic for Perl6 to use these as OPERATORS, the
atoms of the language, when there's not even a platform independent way
to type them in.

Lee

