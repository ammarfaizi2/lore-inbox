Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133099AbRD3KNm>; Mon, 30 Apr 2001 06:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135172AbRD3KNY>; Mon, 30 Apr 2001 06:13:24 -0400
Received: from tilde.ookhoi.dds.nl ([194.109.10.165]:27777 "HELO
	humilis.ookhoi.dds.nl") by vger.kernel.org with SMTP
	id <S133099AbRD3KNM>; Mon, 30 Apr 2001 06:13:12 -0400
Date: Mon, 30 Apr 2001 12:13:05 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Elmer Joandi <elmer@linking.ee>
Cc: Francois Gouget <fgouget@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Aironet doesn't work
Message-ID: <20010430121305.H324@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010430113117.F324@humilis> <Pine.LNX.4.21.0104301133110.9957-100000@ns.linking.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0104301133110.9957-100000@ns.linking.ee>; from elmer@linking.ee on Mon, Apr 30, 2001 at 11:38:08AM +0200
X-Uptime: 13:06:18 up 4 min,  4 users,  load average: 0.07, 0.13, 0.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elmer,

> the whole pcmcia does not work in 2.4.
> Not with latest cardmgr.

My 3com 3c575 (kernel 2.4, 3c59x) works fine, and has done so since I
bought it.

> What makes airo_cs to work is that pcmcia package
> and kernel modules are replaced.

They are not replaced. They have a different name. You can try them both
with the same kernel.

> That is what most of distros do.
> Which overwrites kernel standard ones and really fucks things up
> for pcmcia drivers being in kernel.

I use pcmcia kernel modules and userspace modules together to make both
the 3com and the aironet cards work.

	Ookhoi
