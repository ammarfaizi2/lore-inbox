Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310613AbSCHAHy>; Thu, 7 Mar 2002 19:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310611AbSCHAHo>; Thu, 7 Mar 2002 19:07:44 -0500
Received: from are.twiddle.net ([64.81.246.98]:12699 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S310608AbSCHAHk>;
	Thu, 7 Mar 2002 19:07:40 -0500
Date: Thu, 7 Mar 2002 16:07:34 -0800
From: Richard Henderson <rth@twiddle.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Message-ID: <20020307160734.A28348@twiddle.net>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020305231747.5F95B3FE06@smtp.linux.ibm.com> <Pine.LNX.4.44.0203051525460.1475-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0203051525460.1475-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Tue, Mar 05, 2002 at 03:26:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 03:26:31PM -0800, Davide Libenzi wrote:
> Yes but this is always true   alignof >= sizeof

No.  m68k sets alignof to 2 for all types with sizeof >= 2.


r~
