Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKWh6>; Thu, 11 Jan 2001 17:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbRAKWhr>; Thu, 11 Jan 2001 17:37:47 -0500
Received: from hera.cwi.nl ([192.16.191.1]:56749 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129631AbRAKWhh>;
	Thu, 11 Jan 2001 17:37:37 -0500
Date: Thu, 11 Jan 2001 23:37:33 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101112237.XAA98940.aeb@ark.cwi.nl>
To: linux-kernel@vger.kernel.org, mblack@csihq.com
Subject: Re: swap size
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what's the maximum swap size

See mkswap(8), making sure you have a non-ancient page
(one that mentions Linux 2.1.117).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
