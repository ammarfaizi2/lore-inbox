Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUHAKqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUHAKqN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 06:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUHAKqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 06:46:13 -0400
Received: from [212.239.21.88] ([212.239.21.88]:4553 "EHLO
	supertolla.itapac.net") by vger.kernel.org with ESMTP
	id S265768AbUHAKqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 06:46:12 -0400
Date: Sun, 1 Aug 2004 14:46:05 +0200
From: Fabio Pietrosanti <fabio@pietrosanti.it>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sound fix/patch on sony vaio TR3E/B
References: <20040718103750.96E971D8F7D@supertolla.itapac.net> <20040728172047.131AD1D8F2F@supertolla.itapac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728172047.131AD1D8F2F@supertolla.itapac.net>
X-Operating-System: SCO-OpenVMS 7.3 on vimis-dev.sco.com
Message-Id: <20040801104609.0B8F91D8F23@supertolla.itapac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 07:20:22PM +0200, Takashi Iwai wrote:
> What happens if you turn OFF 'External Amplifier' control on ALSA?

You are right,it works, great! :)

For sony vaio tr3e/b:

amixer -c 0 sset 'External Amplifier' mute

Fabio
