Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSHIMD4>; Fri, 9 Aug 2002 08:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHIMD4>; Fri, 9 Aug 2002 08:03:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34823 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318253AbSHIMD4>; Fri, 9 Aug 2002 08:03:56 -0400
Date: Fri, 9 Aug 2002 13:07:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sf.net
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020809130728.A31506@flint.arm.linux.org.uk>
References: <20020808174227.GE380@cadcamlab.org> <Pine.LNX.4.44.0208091204360.28515-100000@serv> <20020809114741.GB4818@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020809114741.GB4818@cadcamlab.org>; from peter@cadcamlab.org on Fri, Aug 09, 2002 at 06:47:41AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 06:47:41AM -0500, Peter Samuelson wrote:
> I'm convinced.  Now we have
>   !y == n
>   !m == m	(significant for dep_tristate and dep_mbool)
>   !n == n

Erm, !n == n ???

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

