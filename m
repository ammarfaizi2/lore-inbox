Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRFTV3u>; Wed, 20 Jun 2001 17:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263288AbRFTV3k>; Wed, 20 Jun 2001 17:29:40 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:56335 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S262682AbRFTV33>;
	Wed, 20 Jun 2001 17:29:29 -0400
Date: Wed, 20 Jun 2001 15:26:04 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: David Schwartz <davids@webmaster.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Why use threads ( was: Alan Cox quote?)
Message-ID: <20010620152604.B32617@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKAENCPPAA.davids@webmaster.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 02:01:16PM -0700, David Schwartz wrote:
> 	It's very hard to use processes for this purpose. Consider, for example, a
> web server. You don't want to use one process for each client because that
> would limit your scalability (16,000 clients would become difficult, and
> with threads it's trivial). You don't want to use one thread for each client

How is it trivial? How do you debug a 16,000 thread application?

