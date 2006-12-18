Return-Path: <linux-kernel-owner+w=401wt.eu-S1753561AbWLRJDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbWLRJDj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbWLRJDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:03:39 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56695 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbWLRJDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:03:38 -0500
Date: Mon, 18 Dec 2006 12:03:12 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, David Howells <dhowells@redhat.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fallout from atomic_long_t patch
Message-ID: <20061218090309.GA21778@2ka.mipt.ru>
References: <20061217105907.GE17561@ftp.linux.org.uk> <Pine.LNX.4.64.0612170911230.3479@woody.osdl.org> <20061217173201.GA31675@2ka.mipt.ru> <Pine.LNX.4.64.0612171005440.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612171005440.3479@woody.osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 18 Dec 2006 12:03:14 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 10:08:49AM -0800, Linus Torvalds (torvalds@osdl.org) wrote:
> So with that out of the way, I'll just expect that I'll get whatever you 
> decide on through Davem's git tree, once his drunken holiday revelry is 
> over ;)

This is important process - never interrupt it for things like patches
from external developers :)
I will push it through his tree.

> 		Linus

-- 
	Evgeniy Polyakov
