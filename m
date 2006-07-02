Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWGBGJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWGBGJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 02:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWGBGJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 02:09:56 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:58971 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932415AbWGBGJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 02:09:56 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] EXPORT_UNUSED_SYMBOL{,GPL} {,un}register_die_notifier 
In-reply-to: Your message of "Fri, 30 Jun 2006 13:33:17 +0200."
             <20060630113317.GV19712@stusta.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Jul 2006 16:09:05 +1000
Message-ID: <3662.1151820545@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk (on Fri, 30 Jun 2006 13:33:17 +0200) wrote:
>This patch marks {,un}register_die_notifier as 
>EXPORT_UNUSED_SYMBOL{,GPL}.

KDB needs that.

