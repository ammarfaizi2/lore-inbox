Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSCIAWR>; Fri, 8 Mar 2002 19:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291878AbSCIAWH>; Fri, 8 Mar 2002 19:22:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16392 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291948AbSCIAVx>; Fri, 8 Mar 2002 19:21:53 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: system.map
Date: 8 Mar 2002 16:21:41 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6bkil$a7j$1@cesium.transmeta.com>
In-Reply-To: <10236.1010007095@ocs3.intra.ocs.com.au> <WHITEAiPyTxQplr0tEj00000aaa@white.pocketinet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <WHITEAiPyTxQplr0tEj00000aaa@white.pocketinet.com>
By author:    Nicholas Knight <nknight@pocketinet.com>
In newsgroup: linux.dev.kernel
> 
> For what reasons? I see no valid reason for it being the "Wrong" thing 
> to do. I wouldn't even call it QUESTIONABLE. Nor is it simply a 
> "holdover". There are still systems in use whos BIOS simply *does not 
> support* booting past the 1024th cyl.
> 
> 1. Putting stuff in /boot is generaly the "standard" thing to do, 
> generaly won't cause confusion among experienced users, and will make 
> sense to new users; /lib/modules/* will make no sense whatsoever.
> 

Now, you're on a system on which /boot is actually a flash ROM (yes,
such systems exist) or for other reasons very small.

Gunk in /boot is not appreciated.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
