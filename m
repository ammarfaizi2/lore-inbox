Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbREVNS6>; Tue, 22 May 2001 09:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbREVNSt>; Tue, 22 May 2001 09:18:49 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:20372 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261519AbREVNSd>; Tue, 22 May 2001 09:18:33 -0400
Date: Tue, 22 May 2001 09:18:32 -0400
To: Me <bodnar42@bodnar42.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/coda.h
Message-ID: <20010522091831.D6103@cs.cmu.edu>
Mail-Followup-To: Me <bodnar42@bodnar42.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01052121242000.31459@bodnar42.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <01052121242000.31459@bodnar42.dhs.org>; from bodnar42@bodnar42.dhs.org on Mon, May 21, 2001 at 09:24:20PM -0700
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 09:24:20PM -0700, Me wrote:
>  Coda.h assumes that __KERNEL__ can only be defined if __linux__ is, which is 
> painfully false. This allows the kernel compile to get farther on my token 
> FreeBSD box.
> 
> -Ryan

Are you trying to compile a Linux kernel on a FreeBSD machine, or is
this a bug in the Coda kernel module in the FreeBSD tree?

Jan

