Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSCOMHg>; Fri, 15 Mar 2002 07:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292087AbSCOMH0>; Fri, 15 Mar 2002 07:07:26 -0500
Received: from smtp.comcast.net ([24.153.64.2]:39131 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S291753AbSCOMHJ>;
	Fri, 15 Mar 2002 07:07:09 -0500
Date: Fri, 15 Mar 2002 07:07:25 -0500
From: Jerry McBride <mcbrides9@comcast.net>
Subject: xconfig fails when compiling 2.56 or 2.57-pre1
To: linux-kernel@vger.kernel.org
Message-id: <20020315070725.4afd21fa.mcbrides9@comcast.net>
Organization: TEAM LINUX
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.2claws (GTK+ 1.2.8; i586-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-message-flag: Join the Wave and install Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I find that during a compile of either 2.5.6 or 2.5.7-pre1 I get the
following error:

Compiling kernel-2.5.7-pre1

make clean...
OK

make distclean...
OK

make mrproper...
OK

make xconfig...
sound/core/Config.in: 4: can't handle dep_bool/dep_mbool/dep_tristate
condition make[1]: *** [kconfig.tk] Error 1
make: *** [xconfig] Error 2
NOT OK

-- 

*************************************************************************
*****                     Registered Linux User Number 185956
          http://groups.google.com/groups?hl=en&safe=off&group=linux
      7:03am  up 2 days, 13:25,  1 user,  load average: 0.05, 0.07, 0.08
