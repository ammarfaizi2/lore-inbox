Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTFHOic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 10:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTFHOic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 10:38:32 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27405 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261861AbTFHOic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 10:38:32 -0400
Date: Sun, 8 Jun 2003 16:48:18 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/BK] ALSA update
Message-ID: <20030608164818.A13167@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.44.0306061507290.1499-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0306061507290.1499-100000@pnote.perex-int.cz>; from perex@perex.cz on Fri, Jun 06, 2003 at 03:09:07PM +0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela <perex@perex.cz> :
[...]
> <perex@suse.cz> (03/06/06 1.1315)
>    ALSA update
>      - added AZT3328 driver

It doesn't compile as there's no
#define azt3328_t_magic                          0x...
in include/sound/sndmagic.h

--
Ueimor
