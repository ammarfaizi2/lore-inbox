Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSGEUcj>; Fri, 5 Jul 2002 16:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317560AbSGEUci>; Fri, 5 Jul 2002 16:32:38 -0400
Received: from www.transvirtual.com ([206.14.214.140]:25874 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317552AbSGEUch>; Fri, 5 Jul 2002 16:32:37 -0400
Date: Fri, 5 Jul 2002 13:35:06 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: More Fbdev policies.
Message-ID: <Pine.LNX.4.44.0207051302300.30731-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recently I was porting several fbdev drivers over to the new api. Some
driver writers asked to have the changes reverted. So anyone who wants the
drivers reverted to the previous state say so. I will revert them. I did
this not to break any drivers but have a smooth transition. This will not
be the case now.

NOTE:
   I will begin change the upper fbdev layer monday thus breaking most
if not all drivers. It is up to the maintainers to fix them. If not
fixed by the end of the developement cycle they will be dropped.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/


