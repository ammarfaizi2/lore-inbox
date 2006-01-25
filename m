Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWAYCsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWAYCsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 21:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWAYCsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 21:48:10 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:59659 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1750893AbWAYCsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 21:48:09 -0500
Date: Wed, 25 Jan 2006 02:47:55 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060125024755.GA2002@deprecation.cyrius.com>
References: <20060119174600.GT19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119174600.GT19398@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk <bunk@stusta.de> [2006-01-19 18:46]:
> SOUND_TRIDENT
> - ALSA #1293 (device supported by OSS but not by ALSA)
> - maintainer of the OSS driver wants his driver to stay

That driver generally doesn't seem very well maintained in ALSA.
I reported a bug report ages ago about a long delay when loading the
snd_ali5451 ALSA module which doesn't occur with trident but nothing
happened.  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=873
-- 
Martin Michlmayr
http://www.cyrius.com/
