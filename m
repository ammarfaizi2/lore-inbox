Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbUCOQKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUCOQKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:10:04 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:23215 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262637AbUCOQJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:09:58 -0500
Date: Mon, 15 Mar 2004 17:09:56 +0100
From: Romain Lievin <romain@lievin.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: major number 115 changed ! Conflict ?
Message-ID: <20040315160956.GA10401@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that major 115 points on /dev/speaker. 
Nevertheless, this number has been officially (?) allocated to me for tipar.o and tiglusb.o modules in March 2002. These modules are within the 2.4 & 2.6 kernels.

Is there anyone who can tell me whether it's correct ? May a conflict be possible with the speaker device if tipar/tiglusb are loaded ?

Thanks, Romain.
-- 
Romain Liévin (roms):         <romain@lievin.net>
Web site:                     http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"






