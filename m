Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281024AbRKCTo3>; Sat, 3 Nov 2001 14:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281028AbRKCToS>; Sat, 3 Nov 2001 14:44:18 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:239 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281024AbRKCToJ>; Sat, 3 Nov 2001 14:44:09 -0500
Date: Tue, 30 Oct 2001 06:23:18 +0000
From: Stephen Tweedie <sct@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        EXT3 Users <ext3-users@redhat.com>
Subject: Re: Strange memory stats with 2.4.13 and ext3
Message-ID: <20011030062318.B1502@redhat.com>
In-Reply-To: <1004213323.9797.15.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1004213323.9797.15.camel@ixodes.goop.org>; from jeremy@goop.org on Sat, Oct 27, 2001 at 01:08:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 27, 2001 at 01:08:43PM -0700, Jeremy Fitzhardinge wrote:
 
> My gateway/firewall/mailserver machine has been running 2.4.13 for a day
> or so now.  Its basically a stock Linus kernel + ext3-0.9.13 patch (for
> -pre6, with the rej fixed).

Does this happen with stock 2.4.13?  I don't think ext3 touches
anything that could cause this.

Cheers,
 Stephen
