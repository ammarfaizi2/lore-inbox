Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265032AbSJPPQf>; Wed, 16 Oct 2002 11:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265038AbSJPPQf>; Wed, 16 Oct 2002 11:16:35 -0400
Received: from mx5.mail.ru ([194.67.57.15]:58383 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id <S265032AbSJPPQe>;
	Wed, 16 Oct 2002 11:16:34 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: HZ impact
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 194.226.0.89 via proxy [194.226.0.63]
Date: Wed, 16 Oct 2002 19:22:23 +0400
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E181q07-0003Uz-00@f13.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mornin' All,
>         Quick question, what is the impact good/bad of changing the HZ value
> from 100 to 1000 in the asm-i386/param.h?  Besides the fact that it is 10
> times larger.

  potentially lesser latencies vs.
  more cache trashing

---
cheers,
   Samium Gromoff


