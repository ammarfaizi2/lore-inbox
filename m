Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWB0I01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWB0I01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWB0I00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:26:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28325 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932281AbWB0I00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:26:26 -0500
Subject: Re: [Patch 4/7] Add sysctl for delay accounting
From: Arjan van de Ven <arjan@infradead.org>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141028322.5785.60.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141028322.5785.60.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:26:23 +0100
Message-Id: <1141028784.2992.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Allocate task_delay_info for all tasks without one */
> +static int alloc_delays(void)

I'm sorry but this function seems to be highly horrible




