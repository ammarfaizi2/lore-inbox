Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311637AbSCNPwp>; Thu, 14 Mar 2002 10:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311638AbSCNPwf>; Thu, 14 Mar 2002 10:52:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:19350 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311637AbSCNPw2>;
	Thu, 14 Mar 2002 10:52:28 -0500
Date: Thu, 14 Mar 2002 09:51:55 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: David Rees <dbr@greenhydrant.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: libc/1427: gprof does not profile threads <synopsis of the
 problem
Message-ID: <19030000.1016121115@baldur.austin.ibm.com>
In-Reply-To: <20020313192656.B12472@greenhydrant.com>
In-Reply-To: <E16lLTa-0008BN-00@the-village.bc.nu>
 <3C901105.5040605@mandrakesoft.com> <20020313192656.B12472@greenhydrant.com>
X-Mailer: Mulberry/2.2.0b2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, March 13, 2002 07:26:56 PM -0800 David Rees
<dbr@greenhydrant.com> wrote:

> On Wed, Mar 13, 2002 at 09:55:01PM -0500, Jeff Garzik wrote:
>> 
>> Talk about a small world, I just found out today someone I know has been 
>> maintaining the NGPT kernel patches :)
>> 
>> http://gtf.org/~dank/ngpt/
> 
> It even looks like kernel support is included 2.4.19-pre3:
> 
> http://oss.software.ibm.com/pthreads/
> 
> But don't see anything about it in any of the recent change logs...

The relevant line from the changelog is:

- Signal changes for thread groups			(Dave McCracken)

This is the only patch that NGPT needs to work.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

