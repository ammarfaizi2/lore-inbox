Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262030AbREQQox>; Thu, 17 May 2001 12:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262032AbREQQon>; Thu, 17 May 2001 12:44:43 -0400
Received: from cs140085.pp.htv.fi ([213.243.140.85]:60558 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S262030AbREQQof>; Thu, 17 May 2001 12:44:35 -0400
Message-ID: <3B03FFCC.B620AA68@pp.htv.fi>
Date: Thu, 17 May 2001 19:43:56 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA/PDC/Athlon
In-Reply-To: <3B02B824.6FAF5125@pp.htv.fi> <20010516220512.A1400@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> > There is also some new bug in VIA IDE driver. It misdetects cable as 
> > 80-w when it's only 40-w and causes some CRC errors and speed dropping. 
> There were no changes lately in the VIA driver. Can you spot where the
> problems begun?

RH 2.4.2-2 works correctly, but 2.4.4-ac9 doesn't. I think 2.4.3 didn't
work.

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
