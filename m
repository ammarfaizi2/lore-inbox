Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317004AbSFKLVv>; Tue, 11 Jun 2002 07:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSFKLVu>; Tue, 11 Jun 2002 07:21:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40207 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317004AbSFKLVt>; Tue, 11 Jun 2002 07:21:49 -0400
Date: Tue, 11 Jun 2002 12:21:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
Message-ID: <20020611122144.A3665@flint.arm.linux.org.uk>
In-Reply-To: <20020611083947.A1346@flint.arm.linux.org.uk> <Pine.LNX.4.44.0206110510510.24261-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 05:11:13AM -0600, Thunder from the hill wrote:
> On Tue, 11 Jun 2002, Russell King wrote:
> > Is it really worth adding complexity to a build system to work around
> > what is really a GCC bug for just one file?  I don't think so.
> 
> Think big! Think about __future__.

The path to overdesign and excessive featurebloat.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

