Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUFVEOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUFVEOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 00:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUFVEOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 00:14:10 -0400
Received: from bay16-f15.bay16.hotmail.com ([65.54.186.65]:53007 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266465AbUFVEOA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 00:14:00 -0400
X-Originating-IP: [220.224.26.121]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: latten@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: RSA
Date: Tue, 22 Jun 2004 09:43:59 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F15pyLAPDVXLu000036f9@hotmail.com>
X-OriginalArrivalTime: 22 Jun 2004 04:14:00.0077 (UTC) FILETIME=[5833F3D0:01C4580F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey i am gonna look at the code right now.
will keep in touch.

"Tom has indicated a few ways to go about this which I will send you."
waiting for details.

Joy Latten <latten@austin.ibm.com> wrote
>Great!!
>
>Our current goal is to just add RSA encryption and decryption
>to the kernel. We are interested in porting the bignum/mpi and
>rsa implementations from libtomcrypt, http://www.libtomcrypt.org.
>When I say we, I am referring to myself and my coworker, Serge Hallyn.
>You have probably seen a few notes between Serge and Tom, libtomcrypt's
>author, on lkml about RSA.
>
>Tom has indicated that the mpi will perhaps need some work in
>lower stack usage (mp_extpmod uses a bit), lower heap usage
>where possible, and remove any non-supported opcodes (e.g. integer 
>division).
>
>Tom has indicated a few ways to go about this which I will send you.
>
>Let me know when you get to take a look at the code.
>If you have any questions, please let me know. Thanks!!
>
>Joy
>
>
>
> >I would like to work on coding of algorithms and
> >especially developing mpi_t for kernel.
> >
> >Kartikey
> >
> >
> >>From: Joy Latten <latten@austin.ibm.com>
> >>To: kartik_me@hotmail.com
> >>CC: linux-kernel@vger.kernel.org, serue@us.ibm.com
> >>Subject: Re: RSA
> >>Date: Fri, 18 Jun 2004 21:56:10 -0500
> >>
> >>Great!! Thanks!  What are you interested in doing?
> >>
> >>Joy
> >>-------------------------------------------------------------
> >>
> >>
> >>i would like to contribute.
> >>
> >>On Tue, 15 Jun 2004, Joy Latten wrote:
> >>
> >>Is anyone working on implementing RSA encryption/decryption into the
> >>kernel's cryptoapi? If not, I was considering starting such a project.
> >>
> >>James wrote:
> >>
> >>Not that I know of.  Would you be looking at this in terms of a generic
> >>asymmetric crypto API?
> >>

_________________________________________________________________
Pay Cash on delivery on lakhs of products. 
http://go.msnserver.com/IN/50757.asp Only on Baazee.com

