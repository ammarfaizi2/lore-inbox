Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbUCXSs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 13:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUCXSs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 13:48:56 -0500
Received: from h-67-100-3-250.sfldmidn.covad.net ([67.100.3.250]:29056 "EHLO
	morpheous.rootservices.net") by vger.kernel.org with ESMTP
	id S263075AbUCXSsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 13:48:53 -0500
Message-ID: <1106.67.100.3.252.1080154122.squirrel@67.100.3.252>
Date: Wed, 24 Mar 2004 13:48:42 -0500 (EST)
Subject: 
From: "Jeremy D. May" <jeremy@rootservices.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: jeremy@rootservices.net
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this may have been discussed but i did not find anything.


my P4 (was 2.4 but i droped it to a 1.7 when this startted) has been
locking up. previously i was not getting any error msgs or anything just
lock up and no  responce from it. now i get this error:


Mar 24 13:39:25 morpheous kernel: setkey() failed flags=100100
Mar 24 13:39:25 morpheous kernel: failed to load transform for arc4x ECB

that is all i get in my kernel msgs from it (yes that one is a few days old)

i got some strange msgs on the console this last lockup. i dont know what
to do next if someone could point me in the right direcction.



--jeremy
