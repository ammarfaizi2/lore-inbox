Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283771AbRK3T5v>; Fri, 30 Nov 2001 14:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283711AbRK3T5m>; Fri, 30 Nov 2001 14:57:42 -0500
Received: from butterblume.comunit.net ([192.76.134.57]:18436 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S283769AbRK3T5b>; Fri, 30 Nov 2001 14:57:31 -0500
Date: Fri, 30 Nov 2001 20:57:28 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Mauricio Culibrk <mauricio@infohit.si>
cc: linux-kernel@vger.kernel.org
Subject: Re: Device (LAN Cards) Naming
In-Reply-To: <A57F0FE23B31C14E84E38657C03A44982BB3@Godzilla>
Message-ID: <Pine.LNX.4.40.0111302055540.7425-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Mauricio Culibrk wrote:

> Is it possible to define a name for each interface instead of having
> eth0, eth1 etc?

ip link set eth0 down
ip link set eth0 name buggy
ip link set buggy up

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

