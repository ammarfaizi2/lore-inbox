Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTJXS6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbTJXS6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:58:00 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:57350 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262458AbTJXS57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:57:59 -0400
Date: Fri, 24 Oct 2003 20:57:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stacy Woods <stacyw@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugs sitting in the NEW state for more than 28 days
Message-ID: <20031024185754.GC1358@mars.ravnborg.org>
Mail-Followup-To: Stacy Woods <stacyw@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F99243F.8030001@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F99243F.8030001@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1193  Other      Other      bugme-janitors@lists.osdl.org
> Architecture specific flags get passed twice to compiler

Fixed in test7 IIRC.

	Sam
