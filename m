Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289764AbSBRS3T>; Mon, 18 Feb 2002 13:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSBRSNq>; Mon, 18 Feb 2002 13:13:46 -0500
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:36334 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S290843AbSBRSIl>; Mon, 18 Feb 2002 13:08:41 -0500
Date: Mon, 18 Feb 2002 19:06:44 +0100
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: get_fast_time
Message-ID: <20020218190644.A1678@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't install plustek scanner driver, becouse:

/lib/modules/2.4.18-pre9-ac4/misc/pt_drv.o: unresolved symbol get_fast_time

In 2.4.18-pre changelog I found:

- Kill get_fast_time                            (David S. Miller)

What should be used instead?

-- 
decopter - free SDL/OpenGL simulator under heavy development
download it from http://decopter.sourceforge.net
