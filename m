Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWESRwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWESRwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWESRwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:52:49 -0400
Received: from [198.99.130.12] ([198.99.130.12]:27876 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932402AbWESRws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:52:48 -0400
Date: Fri, 19 May 2006 13:52:08 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com,
       clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060519175208.GA4777@ccure.user-mode-linux.org>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518103430.080e3523.akpm@osdl.org> <m1ves2z1fq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ves2z1fq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 05:41:45AM -0600, Eric W. Biederman wrote:
> I think I see a third way of justifying a mainline merge.  We make an
> up-front decision that we will improve the existing chroot jail
> functionality in Linux and start making improvements.  Even if some of
> the improvements are quite small. 

FWIW, UML can use this stuff incrementally.  So, from my point of view,
it's not an all-or-nothing thing.

				Jeff
