Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRDDTbT>; Wed, 4 Apr 2001 15:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbRDDTbJ>; Wed, 4 Apr 2001 15:31:09 -0400
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:57054 "EHLO gin")
	by vger.kernel.org with ESMTP id <S131974AbRDDTax>;
	Wed, 4 Apr 2001 15:30:53 -0400
Date: Wed, 4 Apr 2001 21:30:10 +0200
To: Trevor Nichols <ocdi@ocdi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep
Message-ID: <20010404213010.A30299@h55p111.delphi.afb.lu.se>
In-Reply-To: <3ACA10C7.FB117A53@lexus.com> <Pine.BSF.4.33.0104040835010.88858-100000@ocdi.sb101.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.BSF.4.33.0104040835010.88858-100000@ocdi.sb101.org>; from ocdi@ocdi.org on Wed, Apr 04, 2001 at 08:39:19AM +0930
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 08:39:19AM +0930, Trevor Nichols wrote:

> > ps -eo pid,stat,pcpu,nwchan,wchan=WIDE-WCHAN-COLUMN -o args
> 
> 1230 D     0.0 105cc1 down_write_failed /home/data/mozilla/obj/dist/bin/mozilla-bin

My mysql-server got stuck in down_write_failed today too.
SMP dual PentiumIII system with no swap. I can provide more info at request
and is willing to do more bug-hunting if that is needed.

-- 

//anders/g

