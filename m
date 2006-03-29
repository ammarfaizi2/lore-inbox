Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWC2XSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWC2XSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWC2XSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:18:13 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:655 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751232AbWC2XSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:18:12 -0500
Message-ID: <442B15AA.4070703@vilain.net>
Date: Thu, 30 Mar 2006 11:18:02 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <20060328085206.GA14089@MAIL.13thfloor.at> <4428FB29.8020402@yahoo.com.au> <20060328142639.GE14576@MAIL.13thfloor.at> <44294BE4.2030409@yahoo.com.au> <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <442B11CC.6040503@vilain.net> <20060329231315.GP15997@sorel.sous-sol.org>
In-Reply-To: <20060329231315.GP15997@sorel.sous-sol.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>Not my intention.  Rather, I think from a security standpoint there's
>sanity in controlling things with a single policy.  
>

Yes, certainly. Providing the features to the users in a different way
is a pragmatic alternative to trying to make sure the contained system
gets to use all the same kernel API calls it could without the
virtualisation. The only people who won't like that is are people
consolidating, so they still have to use Xen.

>I'm thinking of
>containers as a simple and logical extension of roles.  Point being,
>the per-object security label can easily include notion of container.
>  
>

If it fits the model well, sounds good.

Sam.
