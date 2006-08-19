Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWHSKsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWHSKsL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWHSKsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:48:11 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:59312 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750774AbWHSKsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:48:10 -0400
Message-ID: <44E6EC68.9060801@dgreaves.com>
Date: Sat, 19 Aug 2006 11:48:08 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: davids@webmaster.com
Cc: alan@lxorguk.ukuu.org.uk,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: GPL Violation?
References: <MDEHLPKNGKAHNMBLJOLKEEBCNOAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEBCNOAB.davids@webmaster.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
>> Ar Gwe, 2006-08-18 am 02:51 -0700, ysgrifennodd David Schwartz:
>> EXPORT_SYMBOL_GPL is clearly a rights management systems. Thats one of
>> its little charms.
> 
> 	No, it is not. If it was, it would violate the GPL. The GPL prohibits any
> restrictions not contained in the GPL, and the GPL doesn't say anything
> about EXPORT_SYMBOL_GPL. To the contrary, the GPL prohibits restrictions on
> use. So EXPORT_SYMBOL_GPL violates the GPL if you are not free to circumvent
> or remove it.
> 
> 	We had this same discussion a few years ago, and my recollection was that
> you agreed that EXPORT_SYMBOL_GPL could not be a license enforcement scheme.
> Which term of the GPL do you think it enforces exactly?

I thought the EXPORT_SYMBOL_GPL had a role in rights _management_ insofar as it
would shows that anyone circumventing it took a conscious act to do so. This may
or may not be valuable in subsequent, possibly legal, discussions.

It's not a rights _enforcement_ scheme on it's own (presumably enforcement
would ultimately involve men with big sticks - aka the legal system). It simply
helps manage (GPL) rights.

David
