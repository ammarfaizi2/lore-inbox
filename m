Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263195AbVFWIT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbVFWIT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVFWIPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:15:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:25060 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262552AbVFWGnn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:43:43 -0400
To: Jean-Pierre Dion <jean-pierre.dion@bull.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] [patch 00/38] CKRM e18: Updated core patches to 2.6.12 and included e17 changes 
In-reply-to: Your message of Thu, 23 Jun 2005 08:36:59 +0200.
             <42BA588B.2090001@bull.net> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16361.1119508980.1@us.ibm.com>
Date: Wed, 22 Jun 2005 23:43:00 -0700
Message-Id: <E1DlLQS-0004Fw-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005 08:36:59 +0200, Jean-Pierre Dion wrote:
> Hi Gerrit,
> 
> just a typo.
> 
> Gerrit Huizenga wrote:
> 
> >All of these changes have been tested on IA32 and PPC64, with CONIG_CKRM
> >  
> >
>                                                                         
>         CONFIG_CKRM    ;-)

Hi Jean-Pierre,

Whew - now I know the code is going out - that was my test to see if anyone
reads it!  :)  Luckily the tests were done with the right CONFIG_CKRM settings.

thanks for noticing - and any other bug (or success) reports are more than
welcome as well!

gerrit
