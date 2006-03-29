Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWC2STS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWC2STS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 13:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWC2STS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 13:19:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5762 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750922AbWC2STR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 13:19:17 -0500
Date: Wed, 29 Mar 2006 10:20:27 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Sam Vilain <sam@vilain.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060329182027.GB14724@sorel.sous-sol.org>
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at> <4428FB29.8020402@yahoo.com.au> <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442A26E9.20608@vilain.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sam Vilain (sam@vilain.net) wrote:
> This raises a very interesting question. All those LSM globals,
> shouldn't those be virtualisable, too? After all, isn't it natural to
> want to apply a different security policy to different sets of processes?

Which globals?  Policy could be informed by relevant containers.

thanks,
-chris
