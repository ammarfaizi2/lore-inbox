Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVBRRQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVBRRQI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVBRRQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:16:07 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:14218 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261425AbVBRROX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:14:23 -0500
Date: Fri, 18 Feb 2005 18:13:54 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: John M Flinchbaugh <john@hjsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: intel8x0 alsa outputs no sound
Message-ID: <20050218171354.GN4161@louise.pinerecords.com>
References: <20050204213337.GA12347@butterfly.hjsoft.com> <874qgqu0ej.fsf@topaz.mcs.anl.gov> <20050212002319.GA12498@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050212002319.GA12498@louise.pinerecords.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Try muting the headphone jack sense control with alsamixer. I had the
> > same problem with rc2 on my t41p, and that solved it.
> 
> This doesn't help on a T40p, I'm afraid.
> No sound in 2.6.11-rc3 with snd-intel8x0.ko, worked all ok in 2.6.10.

Ok, the problem seems to be gone in 2.6.11-rc4.

-- 
Tomas Szepe <szepe@pinerecords.com>
