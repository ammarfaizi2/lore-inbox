Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132585AbRDEJll>; Thu, 5 Apr 2001 05:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132586AbRDEJlc>; Thu, 5 Apr 2001 05:41:32 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:55239 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S132585AbRDEJlU>; Thu, 5 Apr 2001 05:41:20 -0400
Date: Thu, 5 Apr 2001 02:40:34 -0700
From: Andy Chou <acc@CS.Stanford.EDU>
To: Andy Chou <acc@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 15 potential pointer dereference errors in 2.4.3
Message-ID: <20010405024034.A23408@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
In-Reply-To: <20010405015251.A20904@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
In-Reply-To: <20010405015251.A20904@Xenon.Stanford.EDU>; from acc@CS.Stanford.EDU on Thu, Apr 05, 2001 at 01:52:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to mention that these 15 potential errors are only the *new*
ones.  Many of the previously reported dereference errors from 2.4.1 are
still there.

-Andy
