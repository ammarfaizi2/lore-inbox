Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbULATA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbULATA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 14:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbULATA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 14:00:26 -0500
Received: from peabody.ximian.com ([130.57.169.10]:46820 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261411AbULATAW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 14:00:22 -0500
Subject: Re: [WISHLIST] IBM HD Shock detection in Linux
From: Robert Love <rml@novell.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1101926579.18170.48.camel@krustophenia.net>
References: <200412011331.06813.shawn.starr@rogers.com>
	 <1101926579.18170.48.camel@krustophenia.net>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 13:57:07 -0500
Message-Id: <1101927427.4493.74.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 13:42 -0500, Lee Revell wrote:

> What is it?  What does it do?  How does it work?  Got a link?

Modern ThinkPads have accelerometers in their hard drives that detect
sudden movement and spin down the drive or otherwise protect it.

The device is pretty basic, though, and you can just read it directly to
watch the movement of your laptop.  E.g., pick your laptop up and a
little icon in your GNOME panel can show an up arrow.  Pretty neat.

I am sure Google has more information.

	Robert Love


