Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbUKDWi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUKDWi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUKDWiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:38:50 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:61601 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262446AbUKDWfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:35:22 -0500
Date: Thu, 04 Nov 2004 14:33:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adam Heath <doogie@debian.org>, Christoph Hellwig <hch@infradead.org>
cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <305810000.1099607617@flay>
In-Reply-To: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org> <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Wed, Nov 03, 2004 at 04:02:49PM -0500, Timothy Miller wrote:
>> > I'm just curious about why there seems to be so much work going into
>> > supporting a wide range of GCC versions.  If people are willing to
>> > download and compile a new kernel (and migrating from 2.4 to 2.6 is
>> > non-trivial for some systems, like RH9), why aren't they willing to also
>> > download and build a new compiler?
>> 
>> Because the new compilers are a lot slower.
> 
> You can't be serious that this is a problem.

Yes, it is. Mostly they produce larger, slower code too.

M.

