Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319315AbSIKVD7>; Wed, 11 Sep 2002 17:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319331AbSIKVD7>; Wed, 11 Sep 2002 17:03:59 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10109 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S319315AbSIKVD6>; Wed, 11 Sep 2002 17:03:58 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209112108.g8BL8kG23427@devserv.devel.redhat.com>
Subject: Re: PATCH: NFS root file support NFSv3/TCP client
To: hqin@egenera.com (hqin)
Date: Wed, 11 Sep 2002 17:08:45 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, alan@redhat.com
In-Reply-To: <3D7F9D47.78B6B432@egenera.com> from "hqin" at Sep 11, 2002 03:45:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /*This patch is for supporting linux NFS client can be booted from root
> file systerm over NFSv3/TCP. NFS server (NFSv3/TCP) could be NETAPP or
> SUN Solaris. */

2.4.7 is very very old. The same ideas applied to 2.4.18/19 would be
good though
