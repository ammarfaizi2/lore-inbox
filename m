Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278038AbRKDDYA>; Sat, 3 Nov 2001 22:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278057AbRKDDXt>; Sat, 3 Nov 2001 22:23:49 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:23557
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S278038AbRKDDXh>;
	Sat, 3 Nov 2001 22:23:37 -0500
Subject: Re: Strange memory stats with 2.4.13 and ext3
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        EXT3 Users <ext3-users@redhat.com>
In-Reply-To: <20011030062318.B1502@redhat.com>
In-Reply-To: <1004213323.9797.15.camel@ixodes.goop.org> 
	<20011030062318.B1502@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 03 Nov 2001 19:23:35 -0800
Message-Id: <1004844215.11911.35.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-29 at 22:23, Stephen Tweedie wrote:
> Hi,
> 
> On Sat, Oct 27, 2001 at 01:08:43PM -0700, Jeremy Fitzhardinge wrote:
>  
> > My gateway/firewall/mailserver machine has been running 2.4.13 for a day
> > or so now.  Its basically a stock Linus kernel + ext3-0.9.13 patch (for
> > -pre6, with the rej fixed).
> 
> Does this happen with stock 2.4.13?  I don't think ext3 touches
> anything that could cause this.

Someone else reported it happening on stock 2.4.13.  I only mentioned
ext3 because it was there.  I have a number of ext3 machines, and it
only happens on one (with the smallest memory).

	J

