Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264039AbRGCKrB>; Tue, 3 Jul 2001 06:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264032AbRGCKqw>; Tue, 3 Jul 2001 06:46:52 -0400
Received: from [154.32.42.9] ([154.32.42.9]:43157 "EHLO hxn.pointers.co.uk")
	by vger.kernel.org with ESMTP id <S264007AbRGCKqi>;
	Tue, 3 Jul 2001 06:46:38 -0400
Message-ID: <3B41A2F0.97F4F7C2@infront.co.uk>
Date: Tue, 03 Jul 2001 11:48:16 +0100
From: Scott Nursten <scottn@infront.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Scott Nursten <scott.nursten@StreetsOnline.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <3B419A69.A7C08FE1@infront.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

Just to confirm - I've compiled 2.2.19 w/out SMP and it works sweet. 

Rgds,

Scott

Scott Nursten wrote:
> 
> Hi there,
> 
> Was there ever any resolution to this thread? I'm running a bunch of Compaq DL-360's which seem to work fine on the 2.2.19pre series. As soon as I go to 2.2.19, networking doesn't work. Machines are spec'd as follows:
> 
> 2 x P3-933
> 1.4GB RAM
> Compaq RLO card
> Compaq Smart2 Array Controller
> 2 x EtherExpress Pro onboard
> 2 x EtherExpress Pro PCI (the dual port server adapter from Intel)
> 
> Caveat: whenever I run `ifconfig device down` the machine locks up completely.
> 
> Willing to give any information necessary in exchange for working kernel :) Any takers? Tell me what you guys need.
> 
> Rgds,
> 
> --
> Scott Nursten - Systems Administrator
> Streets Online Ltd.
> 
> Direct:         +44 (0) 1293 744 122
> Business:       +44 (0) 1293 402 040
> Fax:            +44 (0) 1293 402 050
> Email:          scottn@streetsonline.co.uk
> 
>       -----------------------------------------------------------------------
>         "Unix is user friendly. It's just selective when choosing friends."
>       -----------------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Scott Nursten - Systems Administrator
Streets Online Ltd.

Direct:		+44 (0) 1293 744 122
Business:       +44 (0) 1293 402 040
Fax:            +44 (0) 1293 402 050
Email:          scottn@streetsonline.co.uk

      -----------------------------------------------------------------------
	"Unix is user friendly. It's just selective when choosing friends."
      -----------------------------------------------------------------------
