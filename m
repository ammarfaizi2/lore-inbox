Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130081AbRCCCfA>; Fri, 2 Mar 2001 21:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130228AbRCCCeu>; Fri, 2 Mar 2001 21:34:50 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:17932 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130081AbRCCCed>;
	Fri, 2 Mar 2001 21:34:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: kmod error 
In-Reply-To: Your message of "Fri, 02 Mar 2001 20:55:37 CDT."
             <FEEBE78C8360D411ACFD00D0B74779718809C6@xsj02.sjs.agilent.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Mar 2001 13:34:26 +1100
Message-ID: <14169.983586866@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001 20:55:37 -0500 , 
"MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com> wrote:
>kmod: failed to exec /sbin/modprobe -s -l binfmt-464c, errno = 8.

You must have support for elf binaries built into the kernel.

