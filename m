Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUJPP7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUJPP7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUJPP7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:59:23 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:30857 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S268765AbUJPP7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:59:10 -0400
Date: Sat, 16 Oct 2004 19:58:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: Erwin Schoenmakers <esc-solutions@planet.nl>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: while building kernel 2.6.8.1. for Alpha (Miata)
Message-ID: <20041016195847.A20976@jurassic.park.msu.ru>
References: <417139A2.5090705@planet.nl> <20041016191704.A20686@jurassic.park.msu.ru> <20041016153017.GE5307@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041016153017.GE5307@stusta.de>; from bunk@stusta.de on Sat, Oct 16, 2004 at 05:30:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 05:30:17PM +0200, Adrian Bunk wrote:
> What are the required versions on Alpha?

IIRC, gcc >= 3.3.4, binutils >= 2.13.

> According to Documentation/Changes, Erwin's versions were OK.

Probably it needs to be updated. I doubt if these versions
work on x86_64 at all, for example.

Ivan.
