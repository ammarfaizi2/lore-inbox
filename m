Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286210AbRL0Emo>; Wed, 26 Dec 2001 23:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286211AbRL0Emf>; Wed, 26 Dec 2001 23:42:35 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:54884 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S286210AbRL0EmY>; Wed, 26 Dec 2001 23:42:24 -0500
Message-ID: <3C2AA64C.2CD1AD6E@randomlogic.com>
Date: Wed, 26 Dec 2001 20:40:44 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Sound issues with kernel 2.4.14 - 2.4.17
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sound worked fine through kernel 2.4.9. Since I upgraded to 2.4.14, and
now to 2.4.17 (I skipped 2.4.10 - 2.4.13) I have several games that are
FUBAR, all sound related: Quake III Arena and Quake II both core dump
initializing sound; Soldier of Fortune, Railroad Tycoon II, Sid Myers
Alpha Centaury all make strange noises with no intelligable game sound.
Tribes 2, Unreal Tournament, and Descent 3 all work fine. GNOME and
Enlightenment sound work fine as well, as does xmms.

I have a SB Live! OEM and have tried compiling with and without the MIDI
module. The main thing is I am trying to do some game development and
it's impossible when sound is FUBAR. Any ideas?

I hate to go back to an earlier kernel as IDE did not work (for me) in
the previous kernels.

PGA
-- 
Paul G. Allen
Owner, Sr. Engineer, Security Specialist
Random Logic/Dream Park
www.randomlogic.com
