Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTBANM6>; Sat, 1 Feb 2003 08:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbTBANM6>; Sat, 1 Feb 2003 08:12:58 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:61446 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264836AbTBANM6>;
	Sat, 1 Feb 2003 08:12:58 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: system call documentation 
In-reply-to: Your message of "Sat, 01 Feb 2003 14:05:19 BST."
             <UTC200302011305.h11D5Jg24212.aeb@smtp.cwi.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Feb 2003 00:22:13 +1100
Message-ID: <11916.1044105733@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Feb 2003 14:05:19 +0100 (MET), 
Andries.Brouwer@cwi.nl wrote:
>Preparing the next man page release, I compared the list of
>system calls for i386 in 2.4.20 with the list of documented
>system calls. It looks like
>
>fgetxattr,
>flistxattr,
>fremovexattr,
>fsetxattr,
>getxattr,
>lgetxattr,
>listxattr,
>llistxattr,
>lremovexattr,
>lsetxattr,
>removexattr,
>setxattr,

*xattr* man pages are in the XFS tree and Andreas Gruenbacher's site,
contents forwarded under separate copy.

getxattr.2:	getxattr, lgetxattr, fgetxattr2
listxattr.2:	listxattr, llistxattr, flistxattr
removexattr.2:	removexattr, lremovexattr, fremovexattr
setxattr.2:	setxattr, lsetxattr, fsetxattr

