Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVC0TcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVC0TcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVC0Tbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:31:36 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:40197 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261488AbVC0Tb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:31:28 -0500
Date: Sun, 27 Mar 2005 21:31:24 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] typo fix in Documentation/eisa.txt
Message-Id: <20050327213124.1e82828b.khali@linux-fr.org>
In-Reply-To: <200503271554.44382.eike-kernel@sf-tec.de>
References: <200503271554.44382.eike-kernel@sf-tec.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eike,

> Trivial typo fix.
> (...)
>  Force the probing code to probe EISA slots even when it cannot find an
> -EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
> +EISA compliant mainboard (nothing appears on slot 0). Default to 0
>  (don't force), and set to 1 (force probing) when either
>  CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.

Wouldn't it rather be "Defaults"?

-- 
Jean Delvare
