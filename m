Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264693AbSKDOpx>; Mon, 4 Nov 2002 09:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264694AbSKDOpx>; Mon, 4 Nov 2002 09:45:53 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:10957 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264693AbSKDOpw>;
	Mon, 4 Nov 2002 09:45:52 -0500
Date: Mon, 4 Nov 2002 15:52:25 +0100
From: bert hubert <ahu@ds9a.nl>
To: Dave Jones <davej@codemonkey.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: an updated post-halloween doc.
Message-ID: <20021104145225.GA15622@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Dave Jones <davej@codemonkey.org.uk>, Theodore Ts'o <tytso@mit.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021101204832.GA3718@suse.de> <20021104142105.GA9197@think.thunk.org> <20021104144515.GA22371@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104144515.GA22371@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 02:45:15PM +0000, Dave Jones wrote:

>  For now, I've moved the htree things off the list on Andreas Dilger's
>  request in light of the corruption reports that were mentioned.
>  Are you any closer in nailing those issues ?

I just found out that I have been using HTREE for quite some time now to no
ill effect. In fact, I only realised when I discovered that a 'find' on the
kernel tree was quicker than I was used to.

2.5.45. Just as a datapoint.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
