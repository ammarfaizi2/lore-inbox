Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRB1NNn>; Wed, 28 Feb 2001 08:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbRB1NNd>; Wed, 28 Feb 2001 08:13:33 -0500
Received: from bitmap.phx.mcd.mot.com ([144.191.11.103]:23818 "EHLO
	bitmap.phx.mcd.mot.com") by vger.kernel.org with ESMTP
	id <S130153AbRB1NNU>; Wed, 28 Feb 2001 08:13:20 -0500
Date: Wed, 28 Feb 2001 06:13:18 -0700
From: peg@bitmap.phx.mcd.mot.com
To: linux-kernel@vger.kernel.org
Subject: Can't compile 2.4.2-ac6
Message-ID: <20010228061317.A28217@bitmap.phx.mcd.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just pulled down the ac6 patch to 2.4.2 kernel and after applying it without
problems I did a make menuconfig with the following result:

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu0: command not found

Paolo

-- 
Paolo Galtieri                            Senior Staff Engineer
Motorola Computer Group                   INTERNET: peg@phx.mcd.mot.com
2900 S. Diablo Way                        VOICE: (602) 438 - 3754
Tempe, AZ 85282

