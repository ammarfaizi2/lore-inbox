Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWGGQ67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWGGQ67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWGGQ67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:58:59 -0400
Received: from [198.99.130.12] ([198.99.130.12]:24014 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932185AbWGGQ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:58:58 -0400
Date: Fri, 7 Jul 2006 12:58:51 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 19/19] UML - Make mconsole version requestshappen in a process
Message-ID: <20060707165851.GA5391@ccure.user-mode-linux.org>
References: <200607070033.k670Xt1w008752@ccure.user-mode-linux.org> <7B4268E5ACB878429B58D4BE5B780E83010B6B42@NWS-EXCH2.nws.oregonstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E83010B6B42@NWS-EXCH2.nws.oregonstate.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 08:31:50AM -0700, Brock, Anthony - NET wrote:
> I'm running UML on an SMP machine, but have never encountered the "hang"
> issue. Is this text still accurate? 

No, it's ancient history.  No one ever figured out what the problem was,
but it hasn't been seen in ages.

> Also, can this command still be used
>  to "wake up" a UML process? Is this still the recommended means for
> verifying that a UML process if running?

No, and no.

				Jeff
