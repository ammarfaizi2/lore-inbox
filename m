Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUCKUmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUCKUju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:39:50 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:46862 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261706AbUCKUfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:35:31 -0500
Message-ID: <4050D0DC.5000404@techsource.com>
Date: Thu, 11 Mar 2004 15:49:32 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Christophe Saout <christophe@saout.de>, linux-kernel@vger.kernel.org
Subject: Re: LKM rootkits in 2.6.x
References: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk> <20040311184835.GA21330@redhat.com>            <1079032587.7517.1.camel@leto.cs.pocnet.net> <200403111930.i2BJU9oh004246@turing-police.cc.vt.edu>
In-Reply-To: <200403111930.i2BJU9oh004246@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:
> On Thu, 11 Mar 2004 20:16:28 +0100, Christophe Saout said:
> 
> 
>>Ugh... this sounds ugly. This should be forbidden. I mean, what are
>>things like EXPORT_SYMBOL_GPL for if drivers are allowed to patch
>>whatever they want?
> 
> 
> If the binary blob knows enough about the innards to be able to do binary
> patching, it's a derived work and should be GPL.

Maybe!

Unless the offset of an unexported symbol relative to an exported one is 
simply a "fact" which therefore can't be copyrighted.

This sort of thing would probably be unethical, but it might be legal.

