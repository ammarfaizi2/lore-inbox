Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUGXBqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUGXBqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 21:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268224AbUGXBqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 21:46:08 -0400
Received: from peabody.ximian.com ([130.57.169.10]:51605 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268223AbUGXBqH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 21:46:07 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040723183107.GB4905@granada.merseine.nu>
References: <1090604517.13415.0.camel@lucy>
	 <20040723183107.GB4905@granada.merseine.nu>
Content-Type: text/plain
Date: Fri, 23 Jul 2004 14:35:44 -0400
Message-Id: <1090607744.15935.6.camel@lucy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-23 at 21:31 +0300, Muli Ben-Yehuda wrote:

> Should we be ignoring the return value of netlink_send here, or
> propogating a possible error to the callers?

If the callers want it, we can definitely return it.  Sure.

	Robert Love


