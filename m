Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136291AbRDVVLB>; Sun, 22 Apr 2001 17:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136294AbRDVVKw>; Sun, 22 Apr 2001 17:10:52 -0400
Received: from mnh-1-22.mv.com ([207.22.10.54]:47368 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S136290AbRDVVKg>;
	Sun, 22 Apr 2001 17:10:36 -0400
Message-Id: <200104222223.RAA04313@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Matthew Wilcox <matthew@wil.cx>
cc: linux-kernel@vger.kernel.org
Subject: Re: Architecture-specific include files 
In-Reply-To: Your message of "Sun, 22 Apr 2001 21:01:18 +0100."
             <20010422210118.Z18464@parcelfarce.linux.theplanet.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Apr 2001 17:23:21 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthew@wil.cx said:
> Would anyone have a problem with this change? 

UML already has a arch/um/include for private headers that the rest of the 
kernel is not allowed to see.

It would mean moving it, which is not a big deal.

				Jeff


