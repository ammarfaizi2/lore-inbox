Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbRK0VUi>; Tue, 27 Nov 2001 16:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282955AbRK0VUd>; Tue, 27 Nov 2001 16:20:33 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:64846 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282945AbRK0VUO>; Tue, 27 Nov 2001 16:20:14 -0500
Date: Tue, 27 Nov 2001 16:20:13 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: "Address family not supported" on RH IBM T23
Message-ID: <20011127162012.M19568@redhat.com>
In-Reply-To: <20011127200522.B27480@indexdata.dk.suse.lists.linux.kernel> <m168nl3-000OVrC@amadeus.home.nl.suse.lists.linux.kernel> <20011127153119.A25554@pimlott.ne.mediaone.net.suse.lists.linux.kernel> <p73elmjsyvh.fsf@amdsim2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p73elmjsyvh.fsf@amdsim2.suse.de>; from ak@suse.de on Tue, Nov 27, 2001 at 10:11:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 10:11:14PM +0100, Andi Kleen wrote:
> In vger (networking development tree) these options have just been removed
> and hardcoded to on. 
> It'll likely show up soon in the main tree soon.
> 
> If that were not the case it would be better to fix iproute2 to give a
> more meaningfull error message.

It would be better to keep the options around, but perhaps hidden under 
a global "embedded systems" option and making the options negative so that 
the default of off results in a working system.

		-ben
-- 
Fish.
