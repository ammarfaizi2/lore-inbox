Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTFALRp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 07:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTFALRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 07:17:44 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:56988 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263752AbTFALRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 07:17:44 -0400
Date: Sun, 1 Jun 2003 13:30:50 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Taral <taral@taral.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modular IDE completely broken
Message-ID: <20030601113050.GE27692@louise.pinerecords.com>
References: <20030601055414.GA11218@taral.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601055414.GA11218@taral.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [taral@taral.net]
> 
> I've submitted this patch before, but I think it got ignored. This makes
> modular IDE at least compile and removes the circular dependencies.
> 
> If there's a reason this patch isn't being applied (it's crappy, someone
> else is working on this problem already, etc.), _please_ tell me!

Alan Cox is working on the problem ATM, check 2.4.21-rc6-ac1.

-- 
Tomas Szepe <szepe@pinerecords.com>
