Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269904AbRHECkJ>; Sat, 4 Aug 2001 22:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269905AbRHECkA>; Sat, 4 Aug 2001 22:40:00 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:62848 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269904AbRHECjs>; Sat, 4 Aug 2001 22:39:48 -0400
Message-ID: <3B6CB0F6.9C4CC86A@randomlogic.com>
Date: Sat, 04 Aug 2001 19:35:34 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: MTRR and Athlon Processors
In-Reply-To: <Pine.LNX.4.30.0108050427270.2519-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Sat, 4 Aug 2001, Paul G. Allen wrote:
> 
> > Jul 29 03:33:00 keroon kernel: mtrr: type mismatch for f8000000,4000000
> > old: write-back new: write-combining
> >
> > This happens quite often, especially with the agpgart and NVdriver
> > modules.
> 
> iirc, this is a problem with the nvidia module, and there's nothing
> the kernel can do about it. Complain to nvidia.
> 

If I knew who to complain to, I would. I used to have a contact there,
but I seem to have lost his e-mail address. :(

(BTW, There's no update to the Tyan [Pheonix] BIOS as yet either.)

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
