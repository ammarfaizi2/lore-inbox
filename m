Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRJYNYD>; Thu, 25 Oct 2001 09:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRJYNXx>; Thu, 25 Oct 2001 09:23:53 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:4830 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273831AbRJYNXo>;
	Thu, 25 Oct 2001 09:23:44 -0400
Date: Thu, 25 Oct 2001 08:24:12 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Separate CLONE_PARENT and CLONE_THREAD behavior
Message-ID: <3140000.1004016252@baldur>
In-Reply-To: <20011025021021.A2928@werewolf.able.es>
In-Reply-To: <117830000.1003951015@baldur>
 <20011025021021.A2928@werewolf.able.es>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, October 25, 2001 02:10:21 +0200 "J . A . Magallon"
<jamagallon@able.es> wrote:

> Will this break current pthreads in glibc 2.2.4 ???

No, the pthread library that comes with glibc doesn't use CLONE_THREAD.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

