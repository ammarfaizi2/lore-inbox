Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290230AbSAOSI3>; Tue, 15 Jan 2002 13:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290229AbSAOSHj>; Tue, 15 Jan 2002 13:07:39 -0500
Received: from ns.suse.de ([213.95.15.193]:37134 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290228AbSAOSHc>;
	Tue, 15 Jan 2002 13:07:32 -0500
Date: Tue, 15 Jan 2002 19:07:31 +0100
From: Dave Jones <davej@suse.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Defining new section for bus driver init
Message-ID: <20020115190731.F32088@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020115050512.GA24580@kroah.com> <Pine.LNX.4.33.0201150951131.827-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201150951131.827-100000@segfault.osdlab.org>; from mochel@osdl.org on Tue, Jan 15, 2002 at 09:53:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 09:53:27AM -0800, Patrick Mochel wrote:
 > > I like it.  Are you going to want to move the other busses to this
 > > (sbus, mca, ecard, zorro, etc.)?
 > Yes, though I don't have a way to test them...

 Not a problem, I'm sure you'll find an army of testers on l-k.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
