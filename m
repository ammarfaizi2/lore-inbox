Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbULGVKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbULGVKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbULGVKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:10:52 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:49643 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261900AbULGVKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:10:43 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH] 2.6.10-rc2-mm4 panic on AMD64
Date: Tue, 7 Dec 2004 22:14:25 +0100
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de
References: <1102369238.2826.8.camel@dyn318077bld.beaverton.ibm.com> <200412070022.23645.rjw@sisk.pl> <1102380640.2826.13.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1102380640.2826.13.camel@dyn318077bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412072214.25719.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 of December 2004 01:50, Badari Pulavarty wrote:
> Ok !! Here is the patch to fix the problem. It works
> fine on my 4-way AMD64 box. 
> 
> Rafael, can you verify on yours ?

It works just fine.

Thanks,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
