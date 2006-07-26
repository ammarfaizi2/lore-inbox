Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWGZPWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWGZPWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWGZPWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:22:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:16331 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750804AbWGZPWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:22:23 -0400
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday(), clock_gettime(), timer_gettime()
References: <44C6D8CD.4040604@comcast.net>
From: Andi Kleen <ak@suse.de>
Date: 26 Jul 2006 17:22:21 +0200
In-Reply-To: <44C6D8CD.4040604@comcast.net>
Message-ID: <p737j205r2q.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser <nigelenki@comcast.net> writes:

>  - gettimeofday() is slow, or so they say, needing several milliseconds
> to execute.

It's not generally true, only sometimes. Please don't spread FUD.

-Andi
