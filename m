Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWDGAyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWDGAyI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 20:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWDGAyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 20:54:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932249AbWDGAyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 20:54:05 -0400
Date: Thu, 6 Apr 2006 17:52:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petr Baudis <pasky@suse.cz>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Script for automated historical Git tree grafting
Message-Id: <20060406175246.3bd1c972.akpm@osdl.org>
In-Reply-To: <20060407004728.GA16588@pasky.or.cz>
References: <20060407004728.GA16588@pasky.or.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
>
> This script enables Git users to easily graft the historical Git tree
>  (Bitkeeper history import) to the current history.

What impact will that have on the (already rather poor) performance of
git-whatchanged, gitk, etc?
