Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143436AbRELA1M>; Fri, 11 May 2001 20:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143431AbRELA0z>; Fri, 11 May 2001 20:26:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24733 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S143427AbRELA0j>;
	Fri, 11 May 2001 20:26:39 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15100.33537.982370.753962@pizda.ninka.net>
Date: Fri, 11 May 2001 17:25:37 -0700 (PDT)
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new version of singlecopy pipe
In-Reply-To: <20010512020742.A1054@werewolf.able.es>
In-Reply-To: <3AFC36BA.B71FC470@colorfullife.com>
	<20010512020742.A1054@werewolf.able.es>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


J . A . Magallon writes:
 > I tried your patch on 2.4.4-ac8, and something strange happens.
 > Untarring linux-2.4.4 takes a little time, disk light flashes,
 > but no files appear on the disk (just 'Makefile', as you will see below).
 > Doing a separate gunzip - tar xf works fine:

What platform?

Later,
David S. Miller
davem@redhat.com
