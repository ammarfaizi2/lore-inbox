Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271091AbTG1UjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbTG1Ui6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:38:58 -0400
Received: from luli.rootdir.de ([213.133.108.222]:36815 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S271091AbTG1Ui1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:38:27 -0400
Date: Mon, 28 Jul 2003 22:38:19 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test1-ac3: alsa snd_via82xx
Message-ID: <20030728203819.GA887@rootdir.de>
References: <20030728101900.GA5326@rootdir.de> <s5h8yqjorox.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8yqjorox.wl@alsa2.suse.de>
Reply-By: Don Jul 31 22:36:48 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test1-ac3 i686
X-No-archive: yes
X-Uptime: 22:36:48 up 5 min,  2 users,  load average: 0.36, 0.35, 0.18
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Takashi!

> perhaps debian's alsaconf script is too old?
> 
> i guess the channels were still muted by some reason.
> usually they are unmuted and volumes are adjusted in the init script
> (or by calling alsactl etc in post-install).

Now it also works inside the kernel.
In fact it seems that the debian script for enabling 
alsa only works with the soundcard as a module.
I will file a bug report.


Many regards, claas
