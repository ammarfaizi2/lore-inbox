Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315452AbSEQHng>; Fri, 17 May 2002 03:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSEQHnf>; Fri, 17 May 2002 03:43:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37388 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315452AbSEQHne>; Fri, 17 May 2002 03:43:34 -0400
Date: Fri, 17 May 2002 08:43:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Htree directory index for Ext2, updated
Message-ID: <20020517084327.A20573@flint.arm.linux.org.uk>
In-Reply-To: <200205170422.g4H4M5q295551@saturn.cs.uml.edu> <E178a8G-00005D-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 07:18:23AM +0200, Daniel Phillips wrote:
> I think you're saying that patch is broken by design.  And what's the
> standard argument for not fixing it?

There are a set of guidelines for generating patches given in the patch
2.5 manpage.  I would suggest people go and read them.  The section is
marked: "NOTES FOR PATCH SENDERS"

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

