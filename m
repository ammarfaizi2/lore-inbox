Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSGRQRm>; Thu, 18 Jul 2002 12:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSGRQRm>; Thu, 18 Jul 2002 12:17:42 -0400
Received: from divine.city.tvnet.hu ([195.38.100.154]:13317 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S318229AbSGRQRl>; Thu, 18 Jul 2002 12:17:41 -0400
Date: Thu, 18 Jul 2002 17:22:31 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Robert Love <rml@tech9.net>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1026495039.1750.379.camel@sinai>
Message-ID: <Pine.LNX.4.30.0207181714420.30902-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Jul 2002, Robert Love wrote:

> I still encourage testing and comments.

Quickly looking through the patch I can't see what prevents total loss of
control at constant memory pressure. For more please see:
	http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.2/0310.html

    Szaka

