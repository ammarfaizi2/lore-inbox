Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265417AbTFMPps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 11:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbTFMPps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 11:45:48 -0400
Received: from angband.namesys.com ([212.16.7.85]:64896 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265417AbTFMPps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 11:45:48 -0400
Date: Fri, 13 Jun 2003 19:59:34 +0400
From: Oleg Drokin <green@namesys.com>
To: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockups with loop'ed sparse files on reiserfs?
Message-ID: <20030613155934.GA19307@namesys.com>
References: <p04320407bb0f79fd523e@[192.168.3.11]> <20030613155634.GA18478@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613155634.GA18478@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jun 13, 2003 at 07:56:34PM +0400, Oleg Drokin wrote:
> > already unpack?) quite a bit of stuff), halfway through the whole 
> > (host) system froze. Still responded to pings, but telnet $host 80 
> > would not show any activity from running apache. Went to the server 
> > room, I could change virtual terminals with Alt-<number>, but could 
> > not log in. Reset.
> Were there anything interesting on the console where your kernel outputs
> its messages (the host kernel?)?

BTW, while we are at it, were there enough space on the partition with sparse
files to hold all the data you was writing there?

Bye,
    Oleg
