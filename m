Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263293AbSJCMkJ>; Thu, 3 Oct 2002 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263294AbSJCMkJ>; Thu, 3 Oct 2002 08:40:09 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.130]:27643 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S263293AbSJCMkI> convert rfc822-to-8bit; Thu, 3 Oct 2002 08:40:08 -0400
From: "Emmeran \"Emmy\" Seehuber" <rototor@rototor.de>
Reply-To: rototor@rototor.de
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 + Loadlin problems -> Use new version
Date: Thu, 3 Oct 2002 15:12:44 +0200
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210031512.44913.rototor@rototor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

i had the same problem with loadlin and kernel 2.5.40. I searched around in 
the web for the sources of loadlin (to add some debug output) and came 
accros:

http://sunsite.ulatina.ac.cr/Unix/Linux/Slackware/slackware-8.1/source/a/loadlin/update-1.6c/

This version of loadlin boots up 2.5.40 very well for me.

cu,
  Emmy
