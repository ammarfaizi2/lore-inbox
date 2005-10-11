Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVJKWvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVJKWvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVJKWvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:51:39 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:17893 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751239AbVJKWvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:51:39 -0400
Subject: Re: [PATCH] [BLUETOOTH] kmalloc + memset -> kzalloc conversion
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dsaxena@plexity.net, torvalds@osdl.org, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051011151805.0d32c840.akpm@osdl.org>
References: <20051001065121.GC25424@plexity.net>
	 <20051011151805.0d32c840.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 00:52:02 +0200
Message-Id: <1129071122.6487.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> Confused.  This patch changes lots of block code, not bluetooth.

I know. This is what I already mailed Deepak, but he never replied.

Regards

Marcel


