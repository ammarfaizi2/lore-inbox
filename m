Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbTIEWZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTIEWZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:25:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:42911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261445AbTIEWZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:25:06 -0400
Date: Fri, 5 Sep 2003 15:24:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: today's futex changes
Message-Id: <20030905152440.0e94d792.shemminger@osdl.org>
In-Reply-To: <3F58F0F7.4090105@redhat.com>
References: <3F58F0F7.4090105@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Sep 2003 13:24:23 -0700
Ulrich Drepper <drepper@redhat.com> wrote:

> ... broke NPTL.

This might explain something odd I am seeing with today's kernel.
On login, Gnome starts and gets most of the way running, but the icons and
screen background are missing.

