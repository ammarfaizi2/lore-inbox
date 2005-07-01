Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVGAUNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVGAUNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVGAUNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:13:41 -0400
Received: from peabody.ximian.com ([130.57.169.10]:49612 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261272AbVGAUMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:12:51 -0400
Subject: Re: Question about patch order
From: Robert Love <rml@novell.com>
To: george@mvista.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42C59EDD.2080206@mvista.com>
References: <42C59EDD.2080206@mvista.com>
Content-Type: text/plain
Date: Fri, 01 Jul 2005 16:12:54 -0400
Message-Id: <1120248774.6745.166.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-01 at 12:51 -0700, George Anzinger wrote:

> Suppose I am doing this prior to my morning coffee, but...
> 
> What should the -rc patch(s) be applied to?  Should it be
> 2.6.x or 2.6.x.n
> e.g. the 2.6.12 kernel or the 2.6.12.2 kernel?

2.6.x.

E.g., apply 2.6.13-rc1 on top of 2.6.12.

> If the former, does the -rc contain the .n stuff?

Supposed to, but the trees aren't formally parent/children.

	Robert Love


