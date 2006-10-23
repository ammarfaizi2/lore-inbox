Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWJWQzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWJWQzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWJWQzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:55:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21219 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932173AbWJWQzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:55:46 -0400
Date: Mon, 23 Oct 2006 09:55:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-Id: <20061023095522.e837ad89.akpm@osdl.org>
In-Reply-To: <200610231607.17525.rjw@sisk.pl>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	<200610231236.54317.rjw@sisk.pl>
	<1161605379.3315.23.camel@nigel.suspend2.net>
	<200610231607.17525.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 23 Oct 2006 16:07:16 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > I'm trying to prepare the patches to make swsusp into suspend2.
> 
> Oh, I see.  Please don't do that.

Why not?
