Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265128AbSJaDB4>; Wed, 30 Oct 2002 22:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSJaDBz>; Wed, 30 Oct 2002 22:01:55 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:32401 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S265128AbSJaDBx>;
	Wed, 30 Oct 2002 22:01:53 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200210310307.GAA29266@sex.inr.ac.ru>
Subject: Re: [STATUS 2.5] October 30, 2002
To: davem@redhat.com (David S. Miller)
Date: Thu, 31 Oct 2002 06:07:34 +0300 (MSK)
Cc: yoshfuji@linux-ipv6.org, boissiere@adiglobal.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021030.184443.87162307.davem@redhat.com> from "David S. Miller" at Oct 30, 2 06:44:43 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Please implement source address selection properly, then resubmit.

Actually, I would propose... not to worry about this for a while.
The issue might happen to dissolve after cleaning the space
around ip6_route_output().

Alexey
