Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264805AbUEERv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264805AbUEERv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264801AbUEERv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:51:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:13594 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S264805AbUEERvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:51:25 -0400
Date: Wed, 5 May 2004 19:56:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Anubis <kerub@gmx.net>
Cc: linux-kernel@vger.kernel.org, petri.koistinen@iki.fi, lathiat@sixlabs.org,
       janitor@sternwelten.at
Subject: Re: Bug for making NETFILTER
Message-ID: <20040505175653.GA2250@mars.ravnborg.org>
Mail-Followup-To: Anubis <kerub@gmx.net>,
	linux-kernel@vger.kernel.org, petri.koistinen@iki.fi,
	lathiat@sixlabs.org, janitor@sternwelten.at
References: <200405050743.42833.kerub@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405050743.42833.kerub@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 07:43:42AM +0200, Anubis wrote:
> make[3]: *** No rule to make target `net/ipv4/netfilter/ipt_mark.o', needed by 
> `net/ipv4/netfilter/built-in.o'.  Stop.
> for linux-2.6.5

It's in my tree.
Check permissions on the file - or maybe something else went wrong whan patching up the kernel src?

	Sam
