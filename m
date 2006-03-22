Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWCVJGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWCVJGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWCVJGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:06:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7626 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751138AbWCVJGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:06:08 -0500
Subject: Re: BIOS causes (exposes?) modprobe (load_module) kernel oops
From: Arjan van de Ven <arjan@infradead.org>
To: jzb@aexorsyst.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603212005.58274.jzb@aexorsyst.com>
References: <200603212005.58274.jzb@aexorsyst.com>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 10:06:05 +0100
Message-Id: <1143018365.2955.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 20:05 -0800, John Z. Bohach wrote:
> Linux 2.6.14.2, yeah, I know, and sorry if this has been fixed...but read on, please,
> this is a new take...

at least enable CONFIG_KALLSYMS to get us a readable backtrace

