Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWGEToY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWGEToY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWGEToY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:44:24 -0400
Received: from ns1.suse.de ([195.135.220.2]:43227 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965005AbWGEToX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:44:23 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell / SUSE Labs
To: Andrew Morton <akpm@osdl.org>
Subject: Re: NULL terminate over-long /proc/kallsyms symbols
Date: Wed, 5 Jul 2006 21:42:08 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200607051859.41638.agruen@suse.de> <20060705123424.2d7d70a7.akpm@osdl.org>
In-Reply-To: <20060705123424.2d7d70a7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607052142.08745.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 5. July 2006 21:34, Andrew Morton wrote:
> Yeah, that assume-the-caller-gave-us-a-128-byte-buffer is a bit rude.  How
> about this?

That's better, thanks.

Andreas
