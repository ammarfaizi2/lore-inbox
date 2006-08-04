Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWHDMuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWHDMuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 08:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbWHDMuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 08:50:44 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:53173 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1161159AbWHDMun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 08:50:43 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Date: Fri, 04 Aug 2006 16:37:25 GMT
Message-ID: <06B3FID11@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
>
> Well, incompatibility is worse in most cases than rationality.
> Could you test the patch really fixes your case, so that I can push it
> to 2.6.17-stable tree?

With your patch, opening /dev/dsp O_RDWR works under 2.6.17 just like it
did under 2.6.16 and previous.
