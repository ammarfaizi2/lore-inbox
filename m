Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280531AbRK0PFF>; Tue, 27 Nov 2001 10:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280133AbRK0PE6>; Tue, 27 Nov 2001 10:04:58 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:29459 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280024AbRK0PEo>;
	Tue, 27 Nov 2001 10:04:44 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ieee1394 
In-Reply-To: Your message of "Tue, 27 Nov 2001 14:49:00 BST."
             <20011127144900.A21231@pcmaftoul.esrf.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Nov 2001 02:04:32 +1100
Message-ID: <4131.1006873472@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 14:49:00 +0100, 
Samuel Maftoul <maftoul@esrf.fr> wrote:
>I installed the latest modutils version I found at kernel.org (rpm -Uvh
>--force --nodeps (nodeps because it won't install because of a tiny kde
>app called ksysguard and I don't need it.)

???? modutils does not need nor provide ksysguard.
# rpm -qp --requires modutils/v2.4/modutils-2.4.12-1.i386.rpm 
rpmlib(PayloadFilesHavePrefix) <= 4.0-1
ld-linux.so.2  
libc.so.6  
/bin/sh  
libc.so.6(GLIBC_2.0)  
libc.so.6(GLIBC_2.1)  
libc.so.6(GLIBC_2.1.3)  
rpmlib(CompressedFileNames) <= 3.0.4-1


