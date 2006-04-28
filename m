Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWD1SPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWD1SPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWD1SPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:15:05 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54918
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751783AbWD1SPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:15:03 -0400
From: Rob Landley <rob@landley.net>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Date: Fri, 28 Apr 2006 14:13:04 -0400
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de, sam@ravnborg.org
References: <1145672241.16166.156.camel@shinybook.infradead.org>
In-Reply-To: <1145672241.16166.156.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281413.05335.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 10:17 pm, David Woodhouse wrote:
> Attached is the current patch from mainline to my working tree at
> git://git.infradead.org/~dwmw2/headers-2.6.git -- visible in gitweb at
> http://git.infradead.org/?p=users/dwmw2/headers-2.6.git;a=summary
>
> It adds a 'make headers_install' target to the kernel makefiles, which
> exports a subset of the headers and runs 'unifdef' on them to clean them
> up for installation in /usr/include.

I'd like to test this out.  Is there an easy way for a non-git-user to get a 
patch against a known -linus release via the above web interface?

Rob
-- 
Never bet against the cheap plastic solution.
