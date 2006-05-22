Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWEVVoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWEVVoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWEVVoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:44:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751217AbWEVVoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:44:05 -0400
Date: Mon, 22 May 2006 14:43:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 1/14/] Doc. sources: expose watchdog
Message-Id: <20060522144347.07b08a8c.akpm@osdl.org>
In-Reply-To: <20060521205810.64b631e2.rdunlap@xenotime.net>
References: <20060521205810.64b631e2.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
>  Documentation/watchdog/pcwd-watchdog.txt |   73 -------------------------------
>   Documentation/watchdog/watchdog-api.txt  |   17 -------
>   Documentation/watchdog/watchdog-simple.c |   15 ++++++
>   Documentation/watchdog/watchdog-test.c   |   68 ++++++++++++++++++++++++++++
>   Documentation/watchdog/watchdog.txt      |   23 ---------

Wouldn't it be better to move all the .c files into a new directory? 
Documentation/src or something?

