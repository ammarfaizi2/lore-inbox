Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTE1ERg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTE1ERg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:17:36 -0400
Received: from bgp01116664bgs.westln01.mi.comcast.net ([68.42.104.18]:4868
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id S264476AbTE1ERf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:17:35 -0400
Message-ID: <3ED43388.6010908@blackmagik.dynup.net>
Date: Tue, 27 May 2003 23:56:56 -0400
From: Eric Blade <eblade@blackmagik.dynup.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.70 and yahoo
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, I understand that there are tons better mesaging programs that do 
this protocol.. but...

Just upgraded to 2.5.70, and yahoo's instant messenger for unix (at 
messenger.yahoo.com ) is acting very strangely.

Normally, a 'ps ax | grep ymessenger' will show one process for every 
messenger window that's open at any given time.

however, with 2.5.70, when you close a window, it's process doesn't go 
away.  It did not exhibit this in 2.5.69, and I'm not
even anywhere near good enough to have the slightest idea where to begin 
looking at it, but i'd figure i'd let someone know.

On the bright side, it seems that this patch might have fixed the 
problems with Mozilla and Evolution locking up with certain
window managers, whenever you'd press a keyboard button in their windows.


-- 
----BEGIN GEEK CODE BLOCK----
Version: 3.1
GB/CS/MC/MU/O @d+ s:- a- C++++ UL++++  !P  L+++ !E W+++ !N !o K? w--- @O++ !M !V PS+ PE- Y PGP- @t 5? X R tv-- b- DI++ D++ G e* h* r  y+ 
----END GEEK CODE BLOCK----




