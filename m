Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129879AbRBNUyQ>; Wed, 14 Feb 2001 15:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRBNUyH>; Wed, 14 Feb 2001 15:54:07 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:39696 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129909AbRBNUx6>; Wed, 14 Feb 2001 15:53:58 -0500
Date: Wed, 14 Feb 2001 14:53:50 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ECN for servers ?
In-Reply-To: <96eqhm$33k$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.3.96.1010214145253.30758C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Feb 2001, H. Peter Anvin wrote:
> By author:    Petru Paler <ppetru@ppetru.net>
> > What is the impact of enabling ECN on the server side ? I mean, will
> > any clients (with broken firewalls) be affected if a SMTP/HTTP server
> > has ECN enabled ?

> Pro: better behaviour in presence of network congestion.
> 
> Con: people behind broken firewalls can't connect.

Since you can use ICMP to tunnel data, a lot of security ppl are
reluctant to stop filtering ICMP :/

	Jeff




