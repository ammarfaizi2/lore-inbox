Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267711AbSLTDf1>; Thu, 19 Dec 2002 22:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267712AbSLTDf1>; Thu, 19 Dec 2002 22:35:27 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:48025 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267711AbSLTDf0>; Thu, 19 Dec 2002 22:35:26 -0500
Date: Fri, 20 Dec 2002 04:43:16 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Jeff Chua <jchua@fedex.com>
Subject: [PATCH] 2.4.20 ide for 2.4.21-pre2
Message-ID: <20021220034316.GF26389@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those who have problems with the shiny new IDE in 2.4.21-pre,
here's a patch that reverts all IDE code to its 2.4.20 state.

The only reason I went through this diff charade is I need an
all-fine-running's PDC driver.  To be applied on top of 2.4.21-pre2.

http://www.geocities.com/szepe_t/2.4.21-pre2-2420ide-1.gz
[588K]

-- 
Tomas Szepe <szepe@pinerecords.com>
