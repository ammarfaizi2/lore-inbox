Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266487AbSKGLJq>; Thu, 7 Nov 2002 06:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266488AbSKGLJq>; Thu, 7 Nov 2002 06:09:46 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:23237 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S266487AbSKGLJp>;
	Thu, 7 Nov 2002 06:09:45 -0500
Date: Thu, 7 Nov 2002 12:16:20 +0100
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Silly advise in bridge Configure help
Message-ID: <20021107111620.GA24125@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021107091822.GA21030@outpost.ds9a.nl> <20021107.014953.58440275.davem@redhat.com> <20021107103905.GA22139@outpost.ds9a.nl> <20021107.025250.35525477.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107.025250.35525477.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 02:52:50AM -0800, David S. Miller wrote:

> Let me try this again, here is a new patch :-)

I'm now trying this one. The previous patch applied fine when I left off the
--dry-run. However, it oopses badly on starting named it appears. The
backtrace is way longer than my screen but it mentions 'udp'.

If this one oopses, I'll try to capture it.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
