Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUI0UWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUI0UWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUI0USL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:18:11 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:15635 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267312AbUI0URz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:17:55 -0400
Date: Mon, 27 Sep 2004 21:17:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20040927211750.A27684@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040927210305.A26680@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Sep 27, 2004 at 09:03:05PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From loooking at the gcc and binutils lists it seems codesourcery is pushing
through all the ARM EABI bullshit.  Maybe we can persuade hjl to keep it
out of his bintuils release?  So far we've been served far better with them
on Linux anyway..

