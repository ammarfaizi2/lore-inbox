Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSHXBOg>; Fri, 23 Aug 2002 21:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHXBOg>; Fri, 23 Aug 2002 21:14:36 -0400
Received: from 24-148-63-229.na.21stcentury.net ([24.148.63.229]:59501 "HELO
	wotke.danapple.com") by vger.kernel.org with SMTP
	id <S315178AbSHXBOg>; Fri, 23 Aug 2002 21:14:36 -0400
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: "Daniel I. Applebaum" <kernel@danapple.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 build failure 
In-Reply-To: Your message of "Fri, 23 Aug 2002 19:19:51 CDT."
             <Pine.LNX.4.44.0208231914080.22497-100000@chaos.physics.uiowa.edu> 
From: "Daniel I. Applebaum" <kernel@danapple.com>
Date: Fri, 23 Aug 2002 20:18:37 -0500
Message-Id: <20020824011842.A46E810B54@wotke.danapple.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the output that Kai asked for:

% gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.0)
% rpm -qa | grep gcc
gcc-c++-2.96-54
kgcc-1.1.2-40
gcc-2.96-54
gcc-g77-2.96-54

Do I really need to change to 2.95.3?

Dan.
