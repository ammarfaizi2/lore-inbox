Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbSIUXVy>; Sat, 21 Sep 2002 19:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276547AbSIUXVy>; Sat, 21 Sep 2002 19:21:54 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:55238 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S276477AbSIUXVx>; Sat, 21 Sep 2002 19:21:53 -0400
Date: Sun, 22 Sep 2002 01:26:34 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
Message-ID: <20020921232634.GA727@neon.hh59.org>
Mail-Followup-To: Thomas Molina <tmolina@cox.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209211746590.2336-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209211746590.2336-100000@dad.molina>
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas!

On Sat, 21 Sep 2002, Thomas Molina wrote:

> 11   JFS software suspend problem   open                 18 Sep 2002

This got fixed by Dave Kleikamp.

But do you remember the JFS Oops problem? It's actually still there but now
we know that it is only there when the kernel is compiled with
CONFIG_PREEMPT enabled. I believe Dave will look into this as well soon.

Regards,
Axel Siebenwirth
