Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265752AbTGDCmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbTGDClr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:41:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41166 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265726AbTGDCk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:40:26 -0400
Subject: Re: Overhead of highpte
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <68160000.1057286782@[10.10.2.4]>
References: <574790000.1057186404@flay>
	 <1057286058.11027.106.camel@nighthawk>  <68160000.1057286782@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1057287245.18849.0.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jul 2003 19:54:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-03 at 19:46, Martin J. Bligh wrote:
> I suspect the problem is that your gcc is such a slow piece of shit,
> you're totally userspace bound. Try 2.95 (just move the /usr/bin/gcc
> symlink on debian).

Yep, you're right.  I thought I _was_ using 2.95.  Oh well.

-- 
Dave Hansen
haveblue@us.ibm.com

