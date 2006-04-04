Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWDDUb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWDDUb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 16:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWDDUb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 16:31:57 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:37036 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750857AbWDDUb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 16:31:56 -0400
Date: Tue, 4 Apr 2006 21:31:52 +0100 (BST)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Ken Moffat <zarniwhoop@ntlworld.com>
cc: Takashi Iwai <tiwai@suse.de>, Jan Niehusmann <jan@gondor.com>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound
 applications
In-Reply-To: <Pine.LNX.4.63.0604042058560.11426@deepthought.mydomain>
Message-ID: <Pine.LNX.4.63.0604042129170.12127@deepthought.mydomain>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
 <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de>
 <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de>
 <Pine.LNX.4.63.0604042058560.11426@deepthought.mydomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1041055340-1144182712=:12127"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1041055340-1144182712=:12127
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT

On Tue, 4 Apr 2006, Ken Moffat wrote:

> On Tue, 4 Apr 2006, Takashi Iwai wrote:
> 
> > What happens if you copy the whole subtree linux/sound and
> > linux/include/sound from 2.6.16?
> 
>  also needs include/linux/sound.h (building at the moment)
> 
 I've been using it now to play sound for 15 or 20 minutes while 
browsing heavily - looks as if the problem is in the sound subtree.  
Sorry.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
---1463809536-1041055340-1144182712=:12127--
