Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288949AbSBMVRA>; Wed, 13 Feb 2002 16:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288950AbSBMVQu>; Wed, 13 Feb 2002 16:16:50 -0500
Received: from ns0.auctionwatch.com ([66.7.130.2]:27402 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S288949AbSBMVQk>; Wed, 13 Feb 2002 16:16:40 -0500
Date: Wed, 13 Feb 2002 13:16:39 -0800
From: Petro <petro@auctionwatch.com>
To: linux-kernel@vger.kernel.org
Subject: Eepro100 driver.
Message-ID: <20020213211639.GB2742@auctionwatch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I'm a little confused about the status of the EEPro100 driver.

    The version in the current kernel has 2 version numbers, and 2
    dates:

    v1.09j-t 9/29/99 Donald Becker
    and
     $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin

     While the driver available at
     http://www.scyld.com/network/eepro100.html has a version and date
     of v1.19 12/19/2001. 

     A couple questions:

     (1) Has this driver code "forked"?

     (2) Is there a technical reason that Mr. Beckers version is not
     being kept up to date? 

     (3) We are experiencing a slight problem with the current version
     ( eth1: card reports no resources.) that is supposedly fixed in
     v1.19. Are there plans to integrate the current v1.19 into the main
     line?

-- 
Share and Enjoy. 
