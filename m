Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbTCSAO6>; Tue, 18 Mar 2003 19:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbTCSAO5>; Tue, 18 Mar 2003 19:14:57 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9358 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262865AbTCSAO4>;
	Tue, 18 Mar 2003 19:14:56 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 19 Mar 2003 01:25:51 +0100 (MET)
Message-Id: <UTC200303190025.h2J0Ppa17873.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Subject: Re: [PATCH] dev_t [1/3]
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From Andrew.Morton@digeo.com  Wed Mar 19 01:16:02 2003

    What does that whole hash/cache/refcount setup in there actually do,
    and why can we afford to remove it for 2.6?

It does nothing. It is dead code.

Andries
