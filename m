Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVIEXZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVIEXZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVIEXZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:25:17 -0400
Received: from ns1.suse.de ([195.135.220.2]:50361 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964930AbVIEXZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:25:16 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" -> "static inline"
Date: Tue, 6 Sep 2005 01:25:03 +0200
User-Agent: KMail/1.8
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050902203123.GT3657@stusta.de>
In-Reply-To: <20050902203123.GT3657@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060125.04490.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 22:31, Adrian Bunk wrote:
> "extern inline" doesn't make much sense.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks applied (with a better description) 

-Andi
