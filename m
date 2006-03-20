Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWCTQ0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWCTQ0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWCTQ0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:26:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8355 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964829AbWCTQ0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:26:18 -0500
Subject: Re: inter-module-put/get replacement
From: Arjan van de Ven <arjan@infradead.org>
To: Giampaolo Bellini <giampaolobellini@ds4.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1142871376.4032.12.camel@Giampaolo>
References: <1142871376.4032.12.camel@Giampaolo>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 17:26:15 +0100
Message-Id: <1142871976.3114.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 17:16 +0100, Giampaolo Bellini wrote:
> Hi
> 
>   looking at intermodule.c I found that inter-modules functions are
> marked as deprecated in 2.6 kernel... are there replacements ? How can I
> extend the functionality of a module without these functions ?


what are you really trying to do? You're not giving enough
information...


