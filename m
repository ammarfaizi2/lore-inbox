Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWCHO7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWCHO7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWCHO7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:59:21 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:32126 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932247AbWCHO7U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:59:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T/rESDCwnCKl+R3uc8fCDToADRqzKdj8W8Uyo2PwW1n4BIgvdSd6T7qSV4eVU9+CYhLDRzyZMBS0o48BGI12bcHJvezJffUxf08yvu9sq8xdWWg8C/wnF6CRfbBx+89u6RZ/Iozr9jwgLuDhQxrTROAotsOgrDzwbgDCPMTdELI=
Message-ID: <161717d50603080659t53462cd0k53969c0d33e06321@mail.gmail.com>
Date: Wed, 8 Mar 2006 09:59:20 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
In-Reply-To: <ec92bc30603080252v7e795b4dm5116d4fe78f92cc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>
	 <20060308102731.GO27946@ftp.linux.org.uk>
	 <ec92bc30603080252v7e795b4dm5116d4fe78f92cc7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Anshuman Gholap <anshu.pg@gmail.com> wrote:
>
> this discussion is totally for betterment of the new users who should
> not be forced to become developers in order to get a trival thing
> running on their desktop/laptop, like device driver.

So far, this discussion is not helping new users at all.

Users need to do a little research before buing hardware, period.
Things are getting better across all platforms and operating systems
(remember the bad old days of jumpers and IRQ conflicts?), it is not
linux-specific.

What is linux-specific in this context is that many people, like
myself, who have contributed code to the kernel under the GPL *don't
want* their code to be used in non-free software, period. Someone who
wants to leverage my work needs to do it under the terms that I allow.
That is the law. Whining is not going to change my mind.

If a company thinks they can make money selling hardware with
closed-source drivers (on some other OS), more power to them. If a
company thinks they can make money selling hardware with open-source
drivers on Linux and want to leverage my work, more power to them
(I'll even help them). But they can't use my work and not release the
code.

It's really that simple.


Dave
