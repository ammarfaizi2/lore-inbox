Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSHRJGy>; Sun, 18 Aug 2002 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSHRJGy>; Sun, 18 Aug 2002 05:06:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57794 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312560AbSHRJGy>;
	Sun, 18 Aug 2002 05:06:54 -0400
Date: Sun, 18 Aug 2002 05:10:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Sweetman <safemode@speakeasy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
In-Reply-To: <1029653085.674.53.camel@psuedomode>
Message-ID: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 18 Aug 2002, Ed Sweetman wrote:

> (overview written in hindsight of writing email)  
> I ran all these tests on ide/host2/bus0/target0/lun0/part1 

Don't be silly - if you want to test anything, devfs is the last thing
you want on the system.

