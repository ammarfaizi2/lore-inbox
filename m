Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314339AbSDRM6v>; Thu, 18 Apr 2002 08:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSDRM6u>; Thu, 18 Apr 2002 08:58:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43784 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314339AbSDRM6t>;
	Thu, 18 Apr 2002 08:58:49 -0400
Date: Thu, 18 Apr 2002 14:57:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Sebastian Droege <sebastian.droege@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020418125757.GF2492@suse.de>
In-Reply-To: <02db01c1e498$7180c170$58dc703f@bnscorp.com> <20020416102510.GI17043@suse.de> <20020416200051.7ae38411.sebastian.droege@gmx.de> <20020416180914.GR1097@suse.de> <20020416204329.4c71102f.sebastian.droege@gmx.de> <3CBD28D1.6070702@evision-ventures.com> <20020417132852.4cf20276.sebastian.droege@gmx.de> <3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de> <3CBEABEF.1030009@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18 2002, Martin Dalecki wrote:
> BTW>  Jens: Do you have any idea what the "sector chaing" in ide-cd is
> good for?! I would love to just get rid of it alltogether!

Sector chaining? Are you talking about the cdrom_read_intr() comments?

-- 
Jens Axboe

