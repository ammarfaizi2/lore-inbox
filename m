Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTEaTTX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 15:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTEaTTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 15:19:23 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:22283 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264508AbTEaTTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 15:19:21 -0400
Date: Sat, 31 May 2003 20:32:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
Message-ID: <20030531203242.B4202@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Kevin P. Fleming" <kpfleming@cox.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <3ED8D5E4.6030107@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3ED8D5E4.6030107@cox.net>; from kpfleming@cox.net on Sat, May 31, 2003 at 09:18:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 09:18:44AM -0700, Kevin P. Fleming wrote:
> Adding patch below solves the problem (yes, I know, userspace is not 
> supposed to use kernel headers...)

So why do you try it anyway?

