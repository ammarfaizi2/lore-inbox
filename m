Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWIQQGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWIQQGw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 12:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWIQQGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 12:06:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:747 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964975AbWIQQGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 12:06:51 -0400
Subject: Re: [PATCH 3 of 11] MTD: Use SEEK_{SET, CUR, END} instead of
	hardcoded values
From: David Woodhouse <dwmw2@infradead.org>
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dhowells@redhat.com
In-Reply-To: <7d3e8ba1ace3bd0315cc.1158455369@turing.ams.sunysb.edu>
References: <7d3e8ba1ace3bd0315cc.1158455369@turing.ams.sunysb.edu>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 17:06:29 +0100
Message-Id: <1158509189.24527.244.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-16 at 21:09 -0400, Josef 'Jeff' Sipek wrote:
> MTD: Use SEEK_{SET,CUR,END} instead of hardcoded values
> 
> Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

Applied to MTD git tree; thanks.

-- 
dwmw2

