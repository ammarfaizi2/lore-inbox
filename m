Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTE3U4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTE3U4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:56:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38669 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264035AbTE3U4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:56:19 -0400
Date: Fri, 30 May 2003 22:09:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030530220936.G9419@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Cole <elenstev@mesatop.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <1054324633.3754.119.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1054324633.3754.119.camel@spc9.esa.lanl.gov>; from elenstev@mesatop.com on Fri, May 30, 2003 at 01:57:13PM -0600
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 01:57:13PM -0600, Steven Cole wrote:
> +int foo(
> +	long bar,
> +	long day,
> +	struct magic *xyzzy
> +)

Is this really part of the kernel coding style?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

