Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBSJOY>; Mon, 19 Feb 2001 04:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRBSJOP>; Mon, 19 Feb 2001 04:14:15 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:51461 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129098AbRBSJOA>; Mon, 19 Feb 2001 04:14:00 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A90E16D.DB868F2@yahoo.com>
Date: Mon, 19 Feb 2001 04:03:41 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: Scott Long <smlong@teleport.com>
CC: linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Linux OS boilerplate
In-Reply-To: <3A902F77.8BF6AB52@teleport.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Long wrote:
> 
> I've been poring over the x86 boot code for a while now and I've been
> considering writing a FAQ on the boot process (mostly for my own use,

[...]

> Does there exist an outline (detailed or not) of the boot process from
> the point of BIOS bootsector load to when the kernel proper begins

IIRC, there is some useful info contained within loadlin.  Also, I
found a doc by hpa called "THE LINUX/I386 BOOT PROTOCOL" in my local
archive of cruft -  I just assumed it was in Documentation/ but
apparently it never made it there (yet).

Paul.


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

