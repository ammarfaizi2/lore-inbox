Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUHDVUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUHDVUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267436AbUHDVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:20:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:31135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267433AbUHDVUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:20:46 -0400
Date: Wed, 4 Aug 2004 14:24:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: chrisw@osdl.org, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlock-as-user for 2.6.8-rc2-mm2
Message-Id: <20040804142401.52b7161e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0408041705130.9630-100000@dhcp83-102.boston.redhat.com>
References: <20040804140102.O1924@build.pdx.osdl.net>
	<Pine.LNX.4.44.0408041705130.9630-100000@dhcp83-102.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> Andrew, could you please apply Chris's patch in addition
> to mine ?

OK, but I don't have any confidence that anyone will be testing it.

Can you think of some way in which we can artificially tweak the patch
for testing so that its new features are getting some exercise?
