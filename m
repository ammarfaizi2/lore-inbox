Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSHZORW>; Mon, 26 Aug 2002 10:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSHZORW>; Mon, 26 Aug 2002 10:17:22 -0400
Received: from dsl-213-023-020-192.arcor-ip.net ([213.23.20.192]:45238 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317945AbSHZORW>;
	Mon, 26 Aug 2002 10:17:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: MM patches against 2.5.31
Date: Mon, 26 Aug 2002 16:22:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <3D6989F7.9ED1948A@zip.com.au> <20020826091038.25100.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020826091038.25100.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jKlX-0001i0-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 August 2002 11:10, Christian Ehrhardt wrote:
> + * A special Problem is the lru lists. Presence on one of these lists
> + * does not increase the page count.

Please remind me... why should it not?

-- 
Daniel
