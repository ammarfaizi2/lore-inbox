Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbSI1NjI>; Sat, 28 Sep 2002 09:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSI1NjI>; Sat, 28 Sep 2002 09:39:08 -0400
Received: from pD9E23260.dip.t-dialin.net ([217.226.50.96]:31624 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261379AbSI1NjH>; Sat, 28 Sep 2002 09:39:07 -0400
Date: Sat, 28 Sep 2002 07:45:00 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Christoph Hellwig <hch@infradead.org>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
In-Reply-To: <20020928143058.A32459@infradead.org>
Message-ID: <Pine.LNX.4.44.0209280743490.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Sep 2002, Christoph Hellwig wrote:
> On Sat, Sep 28, 2002 at 07:27:37AM -0600, Thunder from the hill wrote:
> > Sorry, inline taints the concept. It's supposed to work with any type. 
> > (This time.) We've had crappy times with list.h, so slist.h shall not use 
> > inlines.
> 
> Define crappy times.

 - casts
 - list members had to be in some specified place of the struct
 - some binary disadvantages

Remember? And -- I don't find the defines so unreadable. Try it!

			Thunder

