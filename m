Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVHNT74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVHNT74 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVHNT74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 15:59:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4519 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932174AbVHNT74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 15:59:56 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Lee Revell <rlrevell@joe-job.com>
To: Stephen Pollei <stephen.pollei@gmail.com>
Cc: Jason L Tibbitts III <tibbs@math.uh.edu>,
       "Martin v." =?ISO-8859-1?Q?L=F6wis?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <feed8cdd050814125845fe4e2e@mail.gmail.com>
References: <42FDE286.40707@v.loewis.de>
	 <feed8cdd0508130935622387db@mail.gmail.com>
	 <1123958572.11295.7.camel@mindpipe> <ufazmrl9h3u.fsf@epithumia.math.uh.edu>
	 <feed8cdd050814125845fe4e2e@mail.gmail.com>
Content-Type: text/plain; charset=windows-1251
Date: Sun, 14 Aug 2005 15:59:50 -0400
Message-Id: <1124049592.4918.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-14 at 12:58 -0700, Stephen Pollei wrote:
> My main point was that utf-8 for identifiers, operators, and string
> constants are becoming more prevalent, so BOM support for scripts
> sounds like a Good Idea™ .
> 

I know the alternatives are available.  That doesn't make it any less
idiotic to use non ASCII characters as operators.  I think it's a very
slippery slope.  We write code in ASCII, dammit.

Lee

