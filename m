Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTHYM5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTHYM5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:57:17 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:12524 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261874AbTHYM5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:57:16 -0400
To: Marcus Sundberg <marcus@ingate.com>
Cc: Junio C Hamano <junkio@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: PPPoE Oops with 2.4.22-rc
References: <fa.fl74mr0.184m51s@ifi.uio.no> <fa.k5266bj.136mf8l@ifi.uio.no>
	<7v7k559zu5.fsf@assigned-by-dhcp.cox.net>
	<vebruhz99j.fsf@inigo.ingate.se>
In-Reply-To: <vebruhz99j.fsf@inigo.ingate.se>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 25 Aug 2003 08:57:14 -0400
Message-ID: <87smnpgaj9.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcus Sundberg <marcus@ingate.com> writes:

> I triggered it by doing 'ifconfig down' on the underlying ethernet
> device. It's possible there are other ways to trigger it also. 

Thank you. This has been a bug for a little while. I reported it with 2.4.20 a
few months ago.


-- 
greg

