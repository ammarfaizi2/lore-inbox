Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSDPUVF>; Tue, 16 Apr 2002 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313868AbSDPUVE>; Tue, 16 Apr 2002 16:21:04 -0400
Received: from hera.cwi.nl ([192.16.191.8]:58075 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313867AbSDPUVE>;
	Tue, 16 Apr 2002 16:21:04 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 16 Apr 2002 22:21:02 +0200 (MEST)
Message-Id: <UTC200204162021.g3GKL2c11012.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@zip.com.au
Subject: Re: readahead
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if (max == 0)
>	goto out;       /* No readahead */

Very good. Thanks!

Andries
