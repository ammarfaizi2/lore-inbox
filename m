Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbTDXN4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTDXN4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:56:51 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:58538 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263672AbTDXN4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:56:48 -0400
Message-ID: <3EA7EFF5.3060900@suwalski.net>
Date: Thu, 24 Apr 2003 10:08:53 -0400
From: Pat Suwalski <pat@suwalski.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030331
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Werner Almesberger <wa@almesberger.net>,
       Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
References: <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424134904.GA18149@citd.de>
In-Reply-To: <20030424134904.GA18149@citd.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> To be exact. ALSA mutes all channels, if you don't unset the mute-flags
> on the channels you can increase the volume to 100% without a change.
> :-)

Does it vary from hardware to hardware, distro to distro? On my machine, 
the channels are most certainly not muted, only at 0.

--Pat

