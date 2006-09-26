Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWIZUIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWIZUIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWIZUIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:08:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29356 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932261AbWIZUIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:08:53 -0400
Subject: Re: [PATCH 3/5] UML - disable header exporting
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200609261753.k8QHrMrV005540@ccure.user-mode-linux.org>
References: <200609261753.k8QHrMrV005540@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 21:08:24 +0100
Message-Id: <1159301304.3309.37.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 13:53 -0400, Jeff Dike wrote:
> Disable header exporting on UML since it exports no headers.

Already done upstream.

-- 
dwmw2

