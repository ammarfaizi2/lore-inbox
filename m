Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVALMdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVALMdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVALMdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:33:32 -0500
Received: from mail.enyo.de ([212.9.189.167]:2524 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261164AbVALMd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:33:29 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Steve Bergman <steve@rueb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de>
	<41E2F6B3.9060008@rueb.com>
	<1105457773.15793.28.camel@localhost.localdomain>
Date: Wed, 12 Jan 2005 13:33:28 +0100
In-Reply-To: <1105457773.15793.28.camel@localhost.localdomain> (Alan Cox's
	message of "Tue, 11 Jan 2005 16:10:57 +0000")
Message-ID: <87k6qiomhz.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox:

> On Llu, 2005-01-10 at 21:42, Steve Bergman wrote:
>> handled.  They clam that they sent email to Linus and Andrew and did not 
>> receive a response for 3 weeks, and that is why they released exploit 
>> code into the wild.
>> 
>> Anyone here have any comments on what I should tell him?
>
> They could have reported them to:
> 	vendor-sec

vendor-sec's reputation apparently has been damaged in some circles as
the result of the fake e-matters advisory.  Heise Online also
suggested that the exploit was leaked from vendor-sec ("a natural
conclusion").

> 	cert

CERT/CC shares vulnerability information with anyone who's paying
enough money (read the fine print).  Probably that's not what the
submitters want.

> 	dfn-cert

DFN-CERT is certainly honored to be included in this list, but they
can only forward it to security@ at some vendors and probably
vendor-sec.

If you get stuck, asking someone who has published kernel
vulnerabilities previously what to do is also an option.

But in general, there are plenty of options besides trying to contact
just two kernel developers high up the food chain.  Contacting the
subsystem maintainer is often a possiblity, too.  Of course, it's no
good if the subsystem maintainer tells you to post it to a public
list. 8-/
