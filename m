Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVKUVjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVKUVjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKUVjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:39:32 -0500
Received: from mail.linicks.net ([217.204.244.146]:30367 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750996AbVKUVjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:39:24 -0500
From: Nick Warne <nick@linicks.net>
To: Christian Parpart <trapni@gentoo.org>
Subject: Re: virtual OSS devices [for making selfish apps happy]
Date: Mon, 21 Nov 2005 21:39:12 +0000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511212139.12912.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 11/21/05, Christian Parpart < trapni@gentoo.org> wrote:

> Hi all,

> I'm having some apps running on my desktop that all want
> exclusive access to my sound device just for playing audio
> (and a single app for capturing), namely: 
>
>  * TeamSpeak (VoIP team voice chat)
>  * Cedega (for playing some win32 games on my beloved box) 
>  * KDE/arts (my desktop wants to play some sounds as well wtf) 

Slack 10 with 2.6.14.2 using ALSA (artsd).

I have never had any problems with TS and other apps accessing sound* - KDE 
notifications happen when I am on TS and playing a game of Quake2 while 
listening to xmms on my patented mp3's.

What distro? What kernel? What desktop manager you use?

Nick
* I still can't get firefox and flash sound to work though - all OK in konq.
-- 
http://sourceforge.net/projects/quake2plus/

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

