Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRCIDrt>; Thu, 8 Mar 2001 22:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130428AbRCIDri>; Thu, 8 Mar 2001 22:47:38 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:22858 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129855AbRCIDrb>; Thu, 8 Mar 2001 22:47:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Mircea Damian <dmircea@kappa.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel crash - reboot or hang 
In-Reply-To: Your message of "Thu, 08 Mar 2001 16:17:23 +0200."
             <20010308161723.A9138@linux.kappa.ro> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Mar 2001 14:47:01 +1100
Message-ID: <12647.984109621@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001 16:17:23 +0200, 
Mircea Damian <dmircea@kappa.ro> wrote:
>I had two crashes with 2.4.2 and 2.4.2-pre2 on my local SMTP/POP3/SAMBA/WWW
>server (once under some load and the second one - with 2.4.2-pre2 - while
>it was almost idle).
>Should I use kdb or just remote logging would do the job?

kdb with a serial console.

