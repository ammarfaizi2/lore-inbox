Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVAWEqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVAWEqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVAWEqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:46:10 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:51498 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261220AbVAWEo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:44:58 -0500
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/7] inifiniband: pass dev_t to class core
X-Message-Flag: Warning: May contain useful information
References: <20050123042710.GC9256@vrfy.org>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 22 Jan 2005 20:44:55 -0800
In-Reply-To: <20050123042710.GC9256@vrfy.org> (Kay Sievers's message of
 "Sun, 23 Jan 2005 05:27:10 +0100")
Message-ID: <524qh8pxdk.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Jan 2005 04:44:56.0922 (UTC) FILETIME=[49C843A0:01C50106]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me (assuming the core devt stuff goes in, obviously).

In case it matters:

Acked-by: Roland Dreier <roland@topspin.com>
