Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131160AbRCGTP0>; Wed, 7 Mar 2001 14:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131163AbRCGTPR>; Wed, 7 Mar 2001 14:15:17 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:8977 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131160AbRCGTPE>;
	Wed, 7 Mar 2001 14:15:04 -0500
Date: Wed, 7 Mar 2001 20:14:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: George Garvey <tmwg-linuxknl@inxservices.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
Message-ID: <20010307201437.A5030@suse.cz>
In-Reply-To: <20010306050546.C948@inxservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010306050546.C948@inxservices.com>; from tmwg-linuxknl@inxservices.com on Tue, Mar 06, 2001 at 05:05:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 05:05:46AM -0800, George Garvey wrote:
> 
> > No, just the vt82c686. vt82c686a and vt82c686b are OK.
> 
> So can the vt82c686 be replaced with one of these other chips? What
> action is available to owners of MBs with chips that don't work w/Linux?

It can be replaced if you can desolder a 352 contact BGA chip. I don't
know of anyone who does.

Also, the vt82c686 will work just fine with Linux, but will be limited
to UDMA33, because UDMA66 on this chip does reliably fail.

Furthermore, these chips are very rare - I don't know anyone owning one.

-- 
Vojtech Pavlik
SuSE Labs
