Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSGQUmg>; Wed, 17 Jul 2002 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSGQUmf>; Wed, 17 Jul 2002 16:42:35 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:64190 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316709AbSGQUme>;
	Wed, 17 Jul 2002 16:42:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Robert Love <rml@tech9.net>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch 1/13] minimal rmap
Date: Wed, 17 Jul 2002 22:46:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0207171734390.12241-100000@imladris.surriel.com> <1026938562.1085.59.camel@sinai>
In-Reply-To: <1026938562.1085.59.camel@sinai>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Uvge-0004Q4-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 22:42, Robert Love wrote:
> On Wed, 2002-07-17 at 13:37, Rik van Riel wrote:
> > I don't agree with this, for a very simple reason.
> > 
> > The current rmap patch was created in order to change the
> > VM behaviour as little as possible and ONLY provide an
> > infrastructure.  Benchmarking a completely untuned thing
> > that was built to not change anything is bound to give
> > meaningless results.
> > 
> > I say we _use_ the infrastructure that akpm is trying to
> > get merged now in order to implement something useful.
> 
> I do agree with Rik here.  Once the basic rmap infrastructure is merged
> we need to work on implementing stuff on top of it or else there is no
> point.

Well then we all agree, because that's just what I said.

-- 
Daniel
