Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271105AbRHTGgd>; Mon, 20 Aug 2001 02:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271063AbRHTGgX>; Mon, 20 Aug 2001 02:36:23 -0400
Received: from mail.teraport.de ([195.143.8.72]:59267 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S271109AbRHTGgN>;
	Mon, 20 Aug 2001 02:36:13 -0400
Message-ID: <3B80AFE2.CF1922B7@TeraPort.de>
Date: Mon, 20 Aug 2001 08:36:18 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Hoogerhuis <alexh@ihatent.com>
CC: jason@topic.com.au,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Re: [PATCH] patch's for vmware 2.0.4 for use with linux-2.4.8 
 kernel
In-Reply-To: <3B7D1846.BEB929DE@TeraPort.de> <m3ofpd3cim.fsf@lapper.ihatent.com>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/20/2001 08:36:17 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/20/2001 08:36:28 AM,
	Serialize complete at 08/20/2001 08:36:28 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis wrote:
> 
> 
> I've applied the patch with your fixes, and I've always noticed that
> VMware seem to leak a bit of memory (occording to top and ps). Running
> with 128Mb in a Win2k box it started off at 161Mb process size (140Mb
> RSS) and within 5 minutes it had turned into 203Mb process size (still
> only 140Mb RSS). Have anyone seen similar behavior, and does anyone
> have any pointers to where I can find more info on it?
> 

 probably better to ask the vmware folks. They also have some news
groups served from news.vmware.com

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
