Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWDELlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWDELlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 07:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDELlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 07:41:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26308 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751222AbWDELlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 07:41:17 -0400
Date: Wed, 5 Apr 2006 06:41:12 -0500
From: Robin Holt <holt@sgi.com>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q on audit, audit-syscall
Message-ID: <20060405114112.GA24452@lnx-holt.americas.sgi.com>
References: <200604051127.k35BR3Qe009718@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604051127.k35BR3Qe009718@wildsau.enemy.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 01:27:03PM +0200, Herbert Rosmanith wrote:
> 
> good afternoon,
> 
> I'm searching for a way to trace/intercept syscalls, both before and
> after execution. "ptrace" is not an option (you probably know why).

Does strace do what you are asking for?

Robin
