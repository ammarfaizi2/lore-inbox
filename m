Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWHDHsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWHDHsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWHDHsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:48:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161095AbWHDHsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:48:16 -0400
Date: Fri, 4 Aug 2006 00:48:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: runtime disable for softlockup
Message-Id: <20060804004802.5524bfa6.akpm@osdl.org>
In-Reply-To: <20060801183826.GM22240@redhat.com>
References: <20060801183826.GM22240@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 14:38:26 -0400
Dave Jones <davej@redhat.com> wrote:

> The softlockup detector is damned handy, but a real pain if it
> prevents your distro installer from running.

Why is it triggering??
