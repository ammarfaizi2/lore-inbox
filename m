Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263584AbRFNSIT>; Thu, 14 Jun 2001 14:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263595AbRFNSII>; Thu, 14 Jun 2001 14:08:08 -0400
Received: from zmsvr04.tais.net ([12.106.80.12]:53256 "EHLO zmsvr04.tais.net")
	by vger.kernel.org with ESMTP id <S263584AbRFNSIB>;
	Thu, 14 Jun 2001 14:08:01 -0400
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Subject: Buddy System bitmaps
To: <linux-kernel@vger.kernel.org>
Message-ID: <OFD8310C9F.0457C896-ON88256A6B.0061E161@tais.net>
From: Ramil.Santamaria@tais.toshiba.com
Date: Thu, 14 Jun 2001 11:09:20 -0700
X-MIMETrack: Serialize by Router on zmsvr04/tais_external(Release 5.0.6a |January 17, 2001) at
 06/14/2001 11:08:01 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For this scenario consider a set of 4 page frames.
Frames 0 and 2 are used while frames 1 and 3 are free.

The question is would the bitmap for order 1 be a 1 or 0 for this scenario.

I am not on the list so please cc me on your response.

Thanks in advance.

Ramil J.Santamaria
Toshiba America Information Systems
(949) 461-4379
(949) 206-3439 - fax
ramil.santamaria@tais.toshiba.com

