Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUDLJ1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 05:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUDLJ1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 05:27:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19461 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262031AbUDLJ1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 05:27:08 -0400
Date: Mon, 12 Apr 2004 10:27:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Hinds <dhinds@sonic.net>
Cc: Ivica Ico Bukvic <ico@fuse.net>, daniel.ritz@gmx.ch,
       "'Tim Blechmann'" <TimBlechmann@gmx.net>,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Message-ID: <20040412102701.A5360@flint.arm.linux.org.uk>
Mail-Followup-To: David Hinds <dhinds@sonic.net>,
	Ivica Ico Bukvic <ico@fuse.net>, daniel.ritz@gmx.ch,
	'Tim Blechmann' <TimBlechmann@gmx.net>,
	'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org,
	linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <200404120145.22679.daniel.ritz@gmx.ch> <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass> <20040412082801.A3972@flint.arm.linux.org.uk> <20040412090817.GA3158@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040412090817.GA3158@sonic.net>; from dhinds@sonic.net on Mon, Apr 12, 2004 at 02:08:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 02:08:17AM -0700, David Hinds wrote:
> I don't think so; I'm not sure what the PCI spec has to say about it,

Yup, you're right.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
