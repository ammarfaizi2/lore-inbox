Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290588AbSARSk7>; Fri, 18 Jan 2002 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290615AbSARSkt>; Fri, 18 Jan 2002 13:40:49 -0500
Received: from waste.org ([209.173.204.2]:55479 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S290588AbSARSk3>;
	Fri, 18 Jan 2002 13:40:29 -0500
Date: Fri, 18 Jan 2002 12:39:54 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: Bosko Radivojevic <bole@falcon.etf.bg.ac.yu>,
        Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
        Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: vm philosophising
In-Reply-To: <Pine.LNX.4.33L.0201180235210.32617-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0201181225090.31074-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Rik van Riel wrote:

> On Fri, 18 Jan 2002, Bosko Radivojevic wrote:
>
> > There is no way to make one good VM for all possible situations. But,
> > you can tune/make one VM to work great on large DBMS (e.g.) and
> > tune/make another one to work great on ordinary desktop systems
>
> This is an interesting assertion ... but up to date nobody has
> been able to tell me what exactly should be different between
> these two mythical VMs ;)

There is another VM that has a property that people would like:
deterministically handling memory exhaustion. Unfortunately, that VM
probably can't co-exist with over-commit and the performance gains that
affords.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

