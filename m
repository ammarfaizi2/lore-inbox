Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbTDRNoJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 09:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbTDRNoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 09:44:09 -0400
Received: from ulm9-d9bb50d8.pool.mediaWays.net ([217.187.80.216]:9344 "EHLO
	openworld.de") by vger.kernel.org with ESMTP id S263045AbTDRNoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 09:44:08 -0400
From: Artjom Simon <hoek@linuxartist.org>
Reply-To: hoek@linuxartist.org
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67] SB-AWE32 + ALSA: "snd_sbawe: falsely claims to have parameter pnp"
Date: Fri, 18 Apr 2003 15:56:42 +0200
User-Agent: KMail/1.5.1
References: <200304170126.07245.hoek@linuxartist.org>
In-Reply-To: <200304170126.07245.hoek@linuxartist.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304181556.42209.hoek@linuxartist.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I just wanted to inform people having the same problem, just update the 
/usr/src/linux/sound and /usr/src/linux/sound/include subdirs with the files 
in the alsa-kernel module in alsa CVS.

Thanks to Ruslan U. Zakirov from the ALSA-dev list.

Artjom
