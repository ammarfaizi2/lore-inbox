Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUI0VYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUI0VYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUI0Um2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:42:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56839 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267323AbUI0Ufm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:35:42 -0400
Date: Mon, 27 Sep 2004 21:35:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20040927213532.C26680@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040927210305.A26680@flint.arm.linux.org.uk> <20040927211750.A27684@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040927211750.A27684@infradead.org>; from hch@infradead.org on Mon, Sep 27, 2004 at 09:17:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 09:17:50PM +0100, Christoph Hellwig wrote:
> >From loooking at the gcc and binutils lists it seems codesourcery is pushing
> through all the ARM EABI bullshit.  Maybe we can persuade hjl to keep it
> out of his bintuils release?  So far we've been served far better with them
> on Linux anyway..

Maybe... though I'd like to get some sort of concensus on the specific
issue I mentioned so I can provide an adequate response back to the
folk involved in this specific issue - both the users _and_ the
developers of the toolchain.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
