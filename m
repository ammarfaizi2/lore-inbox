Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268271AbTALJxs>; Sun, 12 Jan 2003 04:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268270AbTALJxs>; Sun, 12 Jan 2003 04:53:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19461 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268271AbTALJxr>; Sun, 12 Jan 2003 04:53:47 -0500
Date: Sun, 12 Jan 2003 10:02:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: two more oddities with the fs/Kconfig file
Message-ID: <20030112100229.A30924@flint.arm.linux.org.uk>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030112073406.GM21826@fs.tum.de> <Pine.LNX.4.44.0301120449530.4974-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0301120449530.4974-100000@dell>; from rpjday@mindspring.com on Sun, Jan 12, 2003 at 04:54:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 04:54:54AM -0500, Robert P. J. Day wrote:
>   so, according to the above, i would *always* get RAMFS, no matter
> what?  there's no way to turn this off?

iirc, RAMFS is used for initramfs (which currently provides the basis for
mounting the root filesystem) and therefore must always be enabled.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

