Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280467AbRKNLIs>; Wed, 14 Nov 2001 06:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280460AbRKNLIi>; Wed, 14 Nov 2001 06:08:38 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:53037 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S280467AbRKNLI3>;
	Wed, 14 Nov 2001 06:08:29 -0500
Message-ID: <20011114120855.C21270@win.tue.nl>
Date: Wed, 14 Nov 2001 12:08:55 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Robert A H Holmberg <rahholmb@cc.helsinki.fi>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Odd partition overlapping problem
In-Reply-To: <Pine.OSF.4.30.0111131627170.14606-100000@sirppi.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.OSF.4.30.0111131627170.14606-100000@sirppi.helsinki.fi>; from Robert A H Holmberg on Tue, Nov 13, 2001 at 04:45:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 04:45:35PM +0200, Robert A H Holmberg wrote:

> I partitioned the drive with linux fdisk, since I don't trust dos fdisk.

But Linux fdisk and DOS FDISK do not have precisely the same function.
Linux fdisk only writes the partition table. DOS FDISK also writes
boot sector information. Generally, you should use the fdisk type
program belonging to OS X before installing OS X.
