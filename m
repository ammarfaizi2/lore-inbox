Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268903AbRHLA6Q>; Sat, 11 Aug 2001 20:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268905AbRHLA54>; Sat, 11 Aug 2001 20:57:56 -0400
Received: from maild.telia.com ([194.22.190.101]:10957 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S268903AbRHLA5x>;
	Sat, 11 Aug 2001 20:57:53 -0400
Date: Sun, 12 Aug 2001 02:58:10 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages: 3-order allocation failed.
Message-ID: <20010812025810.A2972@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

With recent kernel, 2.4.7 and 2.4.8 my syslog file has been filled with
these messages:

Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 3-order allocation failed.
Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 2-order allocation failed.
Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 1-order allocation failed.
Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 3-order allocation failed.

I have not yet found a pattern for when it happens but it doesn't seam to
affect my system all that much. Let me know if you want further info or if
this is a known thing.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
