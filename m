Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTBAQgK>; Sat, 1 Feb 2003 11:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbTBAQgK>; Sat, 1 Feb 2003 11:36:10 -0500
Received: from hera.cwi.nl ([192.16.191.8]:10213 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264931AbTBAQgJ>;
	Sat, 1 Feb 2003 11:36:09 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 1 Feb 2003 17:45:29 +0100 (MET)
Message-Id: <UTC200302011645.h11GjTX02579.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, kaos@ocs.com.au
Subject: Re: system call documentation
Cc: a.gruenbacher@computer.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From kaos@ocs.com.au  Sat Feb  1 14:22:31 2003

    >Preparing the next man page release, I compared the list of
    >system calls for i386 in 2.4.20 with the list of documented
    >system calls. It looks like
    >
    >fgetxattr,
    > ...
    >are undocumented so far.

    *xattr* man pages are in the XFS tree and Andreas Gruenbacher's site,
    contents forwarded under separate copy.

    getxattr.2:    getxattr, lgetxattr, fgetxattr2
    listxattr.2:    listxattr, llistxattr, flistxattr
    removexattr.2:    removexattr, lremovexattr, fremovexattr
    setxattr.2:    setxattr, lsetxattr, fsetxattr

Good. Thanks!

However,

.\" (C) Andreas Gruenbacher, February 2001
.\" (C) Silicon Graphics Inc, September 2001

there is no indication that redistribution (of possibly modified
copies) is permitted.

Andries


