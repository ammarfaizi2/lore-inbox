Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbSJQILu>; Thu, 17 Oct 2002 04:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSJQILu>; Thu, 17 Oct 2002 04:11:50 -0400
Received: from barclay.balt.net ([195.14.162.78]:42946 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S261826AbSJQILt>;
	Thu, 17 Oct 2002 04:11:49 -0400
Date: Thu, 17 Oct 2002 10:14:31 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: 2.5.43-mm1: KDE (3.1 beta2) do not start anymore
Message-ID: <20021017081431.GA16028@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <200210162327.53701.Dieter.Nuetzel@hamburg.de> <20021016225043.4A3732FBBA@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016225043.4A3732FBBA@oscar.casa.dyndns.org>
User-Agent: Mutt/1.3.28i
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 06:50:43PM -0400, Ed Tomlinson wrote:
> Dieter N?tzel wrote:
> 
> > Nothing in the logs.
> > But maybe (short before) sound initialization.
> > Could it be "shared page table" related, too?
> > 
> > W'll try that tomorrow.
> 
> Kde 3.0 has never been able to start here when shared page tables have
> been enabled in an mm kernel.  Still some cleanups and debugging to do 
> it would seem.

I do use 2.4.43-mm1 (with shared pte enabled) - it boots just fine here.

> 
> Ed Tomlinson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
