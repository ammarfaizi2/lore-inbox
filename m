Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTJHWRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 18:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJHWRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 18:17:53 -0400
Received: from gprs148-130.eurotel.cz ([160.218.148.130]:60545 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261784AbTJHWRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 18:17:52 -0400
Date: Thu, 9 Oct 2003 00:17:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-ID: <20031008221741.GA1381@elf.ucw.cz>
References: <1065619951.25818.15.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065619951.25818.15.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> While fixing problems experienced by some scientific users who
> found out that gettimeofday() could sometimes run backward, I

Having time run backward is not really an option; screensavers start
kicking randomly, make has problems, etc, etc.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
