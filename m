Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWIWV2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWIWV2W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 17:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIWV2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 17:28:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1257 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750751AbWIWV2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 17:28:21 -0400
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
From: David Woodhouse <dwmw2@infradead.org>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 22:27:49 +0100
Message-Id: <1159046869.24527.937.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 11:32 +0800, Luke Yang wrote:
>   This is the blackfin architecture for 2.6.18, again.  

Please run 'make headers_check' for blackfin and then verify that you
can build libc against the resulting headers.

-- 
dwmw2

