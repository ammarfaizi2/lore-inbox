Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbTK0Dyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 22:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbTK0Dyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 22:54:45 -0500
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:61826 "EHLO
	gnuppy") by vger.kernel.org with ESMTP id S264422AbTK0Dyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 22:54:44 -0500
Date: Wed, 26 Nov 2003 19:54:29 -0800
To: Diego Calleja Garc?a <aradorlinux@yahoo.es>
Cc: Mike Fedyk <mfedyk@matchmail.com>, john@grabjohn.com, ak@suse.de,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: Fire Engine??
Message-ID: <20031127035429.GA3161@gnuppy.monkey.org>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel> <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel> <p73fzgbzca6.fsf@verdi.suse.de> <200311261135.hAQBZ3Ku000202@81-2-122-30.bradfords.org.uk> <20031126185028.GA1566@mis-mike-wstn.matchmail.com> <20031126201903.1f4a278a.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126201903.1f4a278a.aradorlinux@yahoo.es>
User-Agent: Mutt/1.5.4i
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 08:19:03PM +0100, Diego Calleja Garc?a wrote:
> It works here. I don't know if those numbers represent anything for networking.
> Some of the benchmarks look more like "vm benchmarking". And the ones which
> are measuring latency are valid, considering that BSDs are lacking "preempt"?
> (shooting in the dark)

FreeBSD-current is fully preemptive. The preempt patch, which add
preemption points, is meaningless in that context.

bill

