Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268391AbTAMWiK>; Mon, 13 Jan 2003 17:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268388AbTAMWiG>; Mon, 13 Jan 2003 17:38:06 -0500
Received: from adsl-67-117-70-243.dsl.sntc01.pacbell.net ([67.117.70.243]:32129
	"HELO laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S268389AbTAMWgT>; Mon, 13 Jan 2003 17:36:19 -0500
From: brian@worldcontrol.com
Date: Mon, 13 Jan 2003 14:44:43 -0800
To: Oliver Graf <ograf@rz-online.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-storage problem with >2.4.19
Message-ID: <20030113224443.GA10791@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Oliver Graf <ograf@rz-online.net>, linux-kernel@vger.kernel.org
References: <20030113082553.GA22704@rz-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113082553.GA22704@rz-online.net>
User-Agent: Mutt/1.4i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 09:25:53AM +0100, Oliver Graf wrote:
> Hi!
> 
> If have problems with a Tevion 6in1 Flash Card Reader and newer 2.4
> kernels.
> 
> With 2.4.19(-ac?) everthing works fine. The reader and its four
> subdevices are detectet and accessible. But starting with 2.4.20 the
> kernel will only detect one (the first) subdevice of the reader.
> 
> I tried to find the changes that caused that behaviour, but it did not
> jump at me, so I try here, perhaps someone with more intimate knowledge
> of usb stuff can find the problem.

Others have noticed a substantial loss of functionality in 2.4.20.
Mostly devices not being detected at all.

--
Brian Litzinger
