Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbSK2Nqt>; Fri, 29 Nov 2002 08:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbSK2Nqt>; Fri, 29 Nov 2002 08:46:49 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:9951 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP
	id <S267039AbSK2Nqs>; Fri, 29 Nov 2002 08:46:48 -0500
Date: Fri, 29 Nov 2002 14:54:10 +0100
From: Romain Lievin <rlievin@free.fr>
To: greg@kroah.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: usb_bulk_msg returns EOVERFLOW
Message-ID: <20021129135340.GA2561@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with kernel 2.4.20 , usb_bulk_msg returns EOVERFLOW in my tiglusb module.
I never got this with previous kernels.
What does it mean ?

Thanks, roms.
-- 
Romain Lievin, aka 'roms'  	<roms@lpg.ticalc.org>
Web site 			<http://lpg.ticalc.org/prj_tilp>
"Linux, y'a moins bien mais c'est plus cher !"














