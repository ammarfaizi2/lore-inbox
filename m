Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUJPWHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUJPWHR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 18:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUJPWHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 18:07:16 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:39561 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S268919AbUJPWHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 18:07:09 -0400
Date: Sun, 17 Oct 2004 02:06:36 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: Erwin Schoenmakers <esc-solutions@planet.nl>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: while building kernel 2.6.8.1. for Alpha (Miata)
Message-ID: <20041017020636.A23552@jurassic.park.msu.ru>
References: <417139A2.5090705@planet.nl> <20041016191704.A20686@jurassic.park.msu.ru> <20041016153017.GE5307@stusta.de> <20041016195847.A20976@jurassic.park.msu.ru> <20041016172154.GH5307@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041016172154.GH5307@stusta.de>; from bunk@stusta.de on Sat, Oct 16, 2004 at 07:21:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 07:21:54PM +0200, Adrian Bunk wrote:
> The gcc dependency sounds pretty tough.

Sorry, I was thinking of some miscompilation problems unrelated to kernel.
 
> Why isn't even gcc 3.3.3 able to produce a kernel on Alpha?

Actually, gcc 3.1 should be sufficient.

Ivan.
