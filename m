Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSAXST5>; Thu, 24 Jan 2002 13:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288859AbSAXSTr>; Thu, 24 Jan 2002 13:19:47 -0500
Received: from dsl-213-023-043-085.arcor-ip.net ([213.23.43.85]:27555 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288830AbSAXSTB>;
	Thu, 24 Jan 2002 13:19:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>,
        Mauricio =?iso-8859-1?q?Nu=F1ez?= <mnunez@maxmedia.cl>
Subject: Re: Low latency for recent kernels
Date: Wed, 23 Jan 2002 23:18:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020123091643.A182@earthlink.net> <02012318041500.01883@mauricio.chile.com> <3C4F2D18.5DC72FFE@zip.com.au>
In-Reply-To: <3C4F2D18.5DC72FFE@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ToWU-0002m2-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 23, 2002 10:37 pm, Andrew Morton wrote:
> Probably, poor interactivity on the desktop is more due to
> waiting on disk reads - a combination of bad read latency
> in the presence of write traffic and unfortunate page replacement
> decisions.

Yep, and half-formed ideas of process scheduling.  The good news is, it's all 
being worked on by people who know what they're doing (including, obviously, 
you).

--
Daniel

