Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270311AbSISIAg>; Thu, 19 Sep 2002 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270316AbSISIAg>; Thu, 19 Sep 2002 04:00:36 -0400
Received: from dsl-213-023-020-102.arcor-ip.net ([213.23.20.102]:21647 "EHLO
	starship") by vger.kernel.org with ESMTP id <S270311AbSISIAf>;
	Thu, 19 Sep 2002 04:00:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] contest results for 2.5.36
Date: Thu, 19 Sep 2002 10:05:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Con Kolivas <conman@kolivas.net>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0209181349200.1519-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0209181349200.1519-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17rwJh-0000vS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 September 2002 18:50, Rik van Riel wrote:
> On Wed, 18 Sep 2002, Andrew Morton wrote:
> 
> > > No Load:
> > > Kernel                  Time            CPU
> > > 2.4.19                  68.14           99%
> > > 2.4.20-pre7             68.11           99%
> > > 2.5.34                  69.88           99%
> > > 2.4.19-ck7              68.40           98%
> > > 2.4.19-ck7-rmap         68.73           99%
> > > 2.4.19-cc               68.37           99%
> > > 2.5.36                  69.58           99%
> >
> > page_add/remove_rmap.  Be interesting to test an Alan kernel too.
> 
> Yes, but why are page_add/remove_rmap slower in 2.5 than in
> Con's -rmap kernel ? ;)

I don't know what you guys are going on about, these differences are
getting close to statistically insignificant.

-- 
Daniel
