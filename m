Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319485AbSILVcI>; Thu, 12 Sep 2002 17:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSILVcI>; Thu, 12 Sep 2002 17:32:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:5000 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319529AbSILVcH>;
	Thu, 12 Sep 2002 17:32:07 -0400
Date: Thu, 12 Sep 2002 23:34:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       kernel@street-vision.com, linux-kernel@vger.kernel.org
Subject: Re: AMD 760MPX DMA lockup (partly solved)
Message-ID: <20020912233409.B24954@ucw.cz>
References: <20020912161258.A9056@fi.muni.cz> <200209121815.g8CIFdp06612@Port.imtp.ilyichevsk.odessa.ua> <20020912211452.C29717@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020912211452.C29717@fi.muni.cz>; from kas@informatics.muni.cz on Thu, Sep 12, 2002 at 09:14:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 09:14:52PM +0200, Jan Kasprzak wrote:

> : > When I switch off the DMA (hdparm -d0 /dev/hda), the problem goes away
> : > (however, the disk is very slow, as expected).
> : 
> : At which DMA/UDMA mode it starts to fail?
> 
> 	-d1 -X33 fails.

X33? X33 doesn't make sense.

-- 
Vojtech Pavlik
SuSE Labs
