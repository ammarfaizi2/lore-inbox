Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261172AbRELE1K>; Sat, 12 May 2001 00:27:10 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261175AbRELE1A>; Sat, 12 May 2001 00:27:00 -0400
Received: from geos.coastside.net ([207.213.212.4]:30139 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261172AbRELE0o>; Sat, 12 May 2001 00:26:44 -0400
Mime-Version: 1.0
Message-Id: <p05100300b7226936e01c@[10.128.7.49]>
In-Reply-To: <20010511232031.A2314@bacchus.dhis.org>
In-Reply-To: <p05100303b70eadd613b0@[207.213.214.37]>
 <80BTbI6mw-B@khms.westfalen.de> <p0510030ab716bdcf5556@[207.213.214.37]>
 <20010511133242.B3224@bacchus.dhis.org>
 <p0510030db7221c090810@[10.128.7.49]>
 <20010511232031.A2314@bacchus.dhis.org>
Date: Fri, 11 May 2001 21:21:41 -0700
To: Ralf Baechle <ralf@uni-koblenz.de>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:20 PM -0300 2001-05-11, Ralf Baechle wrote:
>On Fri, May 11, 2001 at 03:49:05PM -0700, Jonathan Lundell wrote:
>
>It's 998 plus a CR/LF sequence which is 1000 bytes, not exactly an odd
>number.  And it's the official successor of RFC 822 which was an official
>STD.

What I meant by "strange" was that it's neither so large a number 
that keeping track is not a concern, nor so small that it fits on a 
screen (or is reasonable to scroll).

Yes, it does appear to be a standard; I was confused because it 
hadn't propagated everywhere.

-- 
/Jonathan Lundell.
