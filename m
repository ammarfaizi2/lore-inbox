Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbULBNW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbULBNW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbULBNWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:22:44 -0500
Received: from [129.6.101.41] ([129.6.101.41]:20405 "EHLO rogue.ncsl.nist.gov")
	by vger.kernel.org with ESMTP id S261610AbULBNW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:22:26 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [WISHLIST] IBM HD Shock detection in Linux
References: <200412011331.06813.shawn.starr@rogers.com>
	<1101926579.18170.48.camel@krustophenia.net>
	<1101927427.4493.74.camel@betsy.boston.ximian.com>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Thu, 02 Dec 2004 08:21:54 -0500
In-Reply-To: <1101927427.4493.74.camel@betsy.boston.ximian.com> (Robert Love's
	message of "Wed, 01 Dec 2004 13:57:07 -0500")
Message-ID: <9cfy8ggesy5.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> writes:

> On Wed, 2004-12-01 at 13:42 -0500, Lee Revell wrote:
>
>> What is it?  What does it do?  How does it work?  Got a link?
>
> Modern ThinkPads have accelerometers in their hard drives that detect
> sudden movement and spin down the drive or otherwise protect it.
>
> The device is pretty basic, though, and you can just read it directly to
> watch the movement of your laptop.  E.g., pick your laptop up and a
> little icon in your GNOME panel can show an up arrow.  Pretty neat.

This needs to be added to the input layer!

Till Harbaum wired up an accelerometer inside his Palm Pilot, then
wrote a marble rolling game that you could play by tilting the palm to
move the marble.  http://www.harbaum.org/till/palm/adxl202/index.html

Ian


