Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbRHLNnM>; Sun, 12 Aug 2001 09:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269184AbRHLNnC>; Sun, 12 Aug 2001 09:43:02 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:7777 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S269186AbRHLNm4>; Sun, 12 Aug 2001 09:42:56 -0400
Date: Sun, 12 Aug 2001 13:49:58 +0100
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Lost interrupt with HPT370
Message-ID: <20010812134958.A1203@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get hde/hdg: lost interrupt messages when booting with 2.4.7/8.

There are two IBM DTLA-307030 drives on the HPT370 interface (m/b is
Abit KA7-100).

2.4.6-ac5 (which I had been using for quite a while) does not have this
problem.

Adam
