Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWG0SW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWG0SW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWG0SW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:22:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750947AbWG0SW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:22:26 -0400
Date: Thu, 27 Jul 2006 11:22:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Should cpuset ABBA deadlock fix be in 2.6.18-rc2-mmx?
Message-Id: <20060727112219.8b052e9b.akpm@osdl.org>
In-Reply-To: <20060727061232.044fc927.pj@sgi.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<20060727061232.044fc927.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 06:12:32 -0700
Paul Jackson <pj@sgi.com> wrote:

> I'd like to encourage including the patch:
> 
>   Cpuset: fix ABBA deadlock with cpu hotplug lock
> 
> in 2.6.18-rc2-mmx.

Linus merged that four days ago.
