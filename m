Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269096AbTCAXqS>; Sat, 1 Mar 2003 18:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbTCAXqS>; Sat, 1 Mar 2003 18:46:18 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:34308 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S269096AbTCAXqR>; Sat, 1 Mar 2003 18:46:17 -0500
Subject: Re: [PATCH] More spelling fixes: loose->lose
From: Steven Cole <elenstev@mesatop.com>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030301202807.GA24998@carfax.org.uk>
References: <20030301202807.GA24998@carfax.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Mar 2003 16:55:26 -0700
Message-Id: <1046562928.7527.423.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 13:28, Hugo Mills wrote:
>    Loose, pronounced with a soft "s", as in the word "spelling", means
> badly-fitting or vague.
> 
>    Lose, with a hard "s", as in the words "laser" and "is", means to
> get rid of something or mislay something.
> 
>    49 occurrences of "loose" where "lose" was intended now fixed.
> Patch against vanilla 2.5.63.
> 
[patch snipped]

Nice try, but I already got this (or a very similar fix) into the tree
five days ago, changeset 1.1035.  Which is why I always diff against the
current tree obtained with a bk pull.  If you don't want or can't use
Larry's fine product, then the bk snapshots are almost as good.

Steven



