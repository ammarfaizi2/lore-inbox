Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUAEVsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAEVsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:48:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48400 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265947AbUAEVsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:48:40 -0500
Message-ID: <3FF9DB9E.20702@transmeta.com>
Date: Mon, 05 Jan 2004 13:48:14 -0800
From: Andrew Morgan <morgan@transmeta.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Norberto Bensa <nbensa@gmx.net>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: chmod -x problem
References: <200312251844.40654.nbensa@gmx.net>	 <20031225173649.0f6b4345.akpm@osdl.org> <1072535267.1936.9.camel@nb.suse.de>
In-Reply-To: <1072535267.1936.9.camel@nb.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> that defines the base set of required capabilities. So it appears that
> Andrew Morgan based the Linux Capabilities implementation on an earlier
> draft.

FWIW it is definitely the case that I based this part of the port on a 
slightly earlier version of the draft. (I think it was 15.)

Cheers

Andrew

