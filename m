Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290993AbSAaJYs>; Thu, 31 Jan 2002 04:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290999AbSAaJYj>; Thu, 31 Jan 2002 04:24:39 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:61444 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290993AbSAaJY0>; Thu, 31 Jan 2002 04:24:26 -0500
Date: Thu, 31 Jan 2002 12:24:24 +0300
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@suse.de>, Sebastian Dr?ge <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020131122424.A874@namesys.com>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de> <20020130201054.6e150f78.sebastian.droege@gmx.de> <20020130201757.Q24012@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130201757.Q24012@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 30, 2002 at 08:17:57PM +0100, Dave Jones wrote:

Ok, as of now, I tried vanilla 2.5.3 and it works.
2.5.2-dj7 breaks instantly on the first truncate call to reiserfs.
I tried to dig up the difference between these 2 kernels but have not found
anything that will change that behaviour yet. And resierfs code is identical.
But dj7 seems to have a lot of modifications in the mm/* and fs/* stuff
compared to 2.5.3

Bye,
    Oleg
