Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbTDKWyZ (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTDKWxZ (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:53:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:60813 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262000AbTDKWxG (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:53:06 -0400
Date: Fri, 11 Apr 2003 15:53:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
Message-ID: <156450000.1050101626@flay>
In-Reply-To: <200304111823_MC3-1-3412-C273@compuserve.com>
References: <200304111823_MC3-1-3412-C273@compuserve.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I thought you might be seriously in need of some mental evaluation
>> when you claimed that users "liked looking up error numbers in
>> manuals".
> 
> 
>  Not the looking up part, but that fact that the explanation
> for every single message the software could emit was available.
> 
>  Today it's all HTML documents or PDFs or something, but it's still
> a staggering amount of information.  I have ~300MB of Oracle
> documentation on one desktop, 6 of it server error messages alone.
> Every possible message is explained to some extent, except this one:

IMHO, it'd be better to just make the kernel error messages meaningful.
Keeping a large pile of documentation in sync with the source is
a PITA.

M.

