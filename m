Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbRFZApg>; Mon, 25 Jun 2001 20:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264712AbRFZApZ>; Mon, 25 Jun 2001 20:45:25 -0400
Received: from imo-m05.mx.aol.com ([64.12.136.8]:49107 "EHLO
	imo-m05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S264688AbRFZApH>; Mon, 25 Jun 2001 20:45:07 -0400
Date: Mon, 25 Jun 2001 20:44:57 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: linux-kernel@vger.kernel.org
Subject: Difference between get_free_page() and page_cache_alloc() ?
Mime-Version: 1.0
Message-ID: <25CCDDD8.57E86219.0F76C228@netscape.net>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

get_free_page() returns a pointer to a page while page_cache_alloc returns a pointer to a page struct. 
Is page_cache_alloc more efficient than get_free_page()?

Also, does get_free_page returns a pointer to a contiguous block of physical memory?

Thanks
__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
