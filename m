Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbSI1Cxd>; Fri, 27 Sep 2002 22:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbSI1Cxd>; Fri, 27 Sep 2002 22:53:33 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:50884 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262633AbSI1Cxc>;
	Fri, 27 Sep 2002 22:53:32 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209280258.GAA02712@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
To: davem@redhat.com (David S. Miller)
Date: Sat, 28 Sep 2002 06:58:22 +0400 (MSD)
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
In-Reply-To: <20020927.193541.89132835.davem@redhat.com> from "David S. Miller" at Sep 27, 2 07:35:41 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This only runs at connect time

... and also at ip6_build_xmit(). Connected dgram sockets are marginal.

Alexey
