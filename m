Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUDNTHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUDNTHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:07:45 -0400
Received: from mail.shareable.org ([81.29.64.88]:40609 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261439AbUDNTHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:07:44 -0400
Date: Wed, 14 Apr 2004 20:06:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: READONLY_EXEC is a curious name
Message-ID: <20040414190653.GB12105@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not important.

PAGE_READONLY_EXEC is defined in <asm-x86_64/pgtable.h>.

Does anyone else think PAGE_READONLY_EXEC is an odd name for a set of
flags which enables read _and_ execute permission?  What about
PAGE_READEXEC instead?

-- Jamie

