Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWAVKjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWAVKjo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 05:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWAVKjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 05:39:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:10767 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751274AbWAVKjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 05:39:43 -0500
Date: Sun, 22 Jan 2006 11:39:05 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] add /proc/*/pmap files
Message-ID: <20060122103904.GT7142@w.ods.org>
References: <787b0d920601220150n2e34e376i856cc583a372e1f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920601220150n2e34e376i856cc583a372e1f2@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,

On Sun, Jan 22, 2006 at 04:50:17AM -0500, Albert Cahalan wrote:
(...)
> If the patch doesn't make it to the list intact, somebody
> please give me a hand. Non-mangling email systems are
> getting to be kind of exotic these days.  :-(

It failed :
 
> diff -Naurd old/Documentation/filesystems/proc/pmap
> new/Documentation/filesystems/proc/pmap
> --- old/Documentation/filesystems/proc/pmap     1969-12-31
> 19:00:00.000000000 -0500
> +++ new/Documentation/filesystems/proc/pmap     2006-01-22
> 03:42:59.000000000 -0500

You seem to have used a web interface, you might try to tune its options
to accept very large lines (more than one hundred of chars). Also, you
might try to attach it as text only, with some mailers, the file remains
intact and does not need any decoding on the receiver side.

Regards,
Willy

