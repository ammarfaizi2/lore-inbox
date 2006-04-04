Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWDDUBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWDDUBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 16:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDDUBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 16:01:04 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:10231 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750832AbWDDUBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 16:01:03 -0400
Date: Tue, 4 Apr 2006 21:00:59 +0100 (BST)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Takashi Iwai <tiwai@suse.de>
cc: Jan Niehusmann <jan@gondor.com>, Ken Moffat <zarniwhoop@ntlworld.com>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound
 applications
In-Reply-To: <s5h7j656tpp.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.63.0604042058560.11426@deepthought.mydomain>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
 <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de>
 <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1788178793-1144180859=:11426"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1788178793-1144180859=:11426
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT

On Tue, 4 Apr 2006, Takashi Iwai wrote:

> What happens if you copy the whole subtree linux/sound and
> linux/include/sound from 2.6.16?

 also needs include/linux/sound.h (building at the moment)

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
---1463809536-1788178793-1144180859=:11426--
