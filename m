Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSKNAfi>; Wed, 13 Nov 2002 19:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSKNAfi>; Wed, 13 Nov 2002 19:35:38 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:39589 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264683AbSKNAfh>; Wed, 13 Nov 2002 19:35:37 -0500
Date: Wed, 13 Nov 2002 22:42:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove hugetlb syscalls
In-Reply-To: <20021113184555.B10889@redhat.com>
Message-ID: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Benjamin LaHaise wrote:

> Since the functionality of the hugetlb syscalls is now available via
> hugetlbfs with better control over permissions, could you apply the
> following patch that gets rid of a lot of duplicate and unnescessary
> code by removing the two hugetlb syscalls?

#include <massive_applause.h>

Yes, lets get rid of this ugliness before somebody actually
finds a way to use these syscalls...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

