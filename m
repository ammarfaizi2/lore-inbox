Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVH3Xeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVH3Xeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVH3Xeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:34:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51153 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751438AbVH3Xeg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:34:36 -0400
Date: Wed, 31 Aug 2005 00:34:40 +0100
From: viro@ZenIV.linux.org.uk
To: Andrew Morton <akpm@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, phillips@istop.com,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-ID: <20050830233440.GA26264@ZenIV.linux.org.uk>
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <20050830162846.5f6d0a53.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830162846.5f6d0a53.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 04:28:46PM -0700, Andrew Morton wrote:
> Sure, but all that copying-and-pasting really sucks.  I'm sure there's some
> way of providing the slightly different semantics from the same codebase?

Careful - you've almost reinvented the concept of library, which would
violate any number of patents...
