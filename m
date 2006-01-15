Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWAOVGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWAOVGB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWAOVGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:06:00 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:49079 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP
	id S1750850AbWAOVF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:05:59 -0500
Date: Sun, 15 Jan 2006 21:05:33 +0200 (EET)
From: Samuel Ortiz <samuel.ortiz@nokia.com>
X-X-Sender: samuel@irie
Reply-To: samuel.ortiz@nokia.com
To: ext Stuffed Crust <pizza@shaftnet.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Johannes Berg <johannes@sipsolutions.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
In-Reply-To: <20060115152034.GA1722@shaftnet.org>
Message-ID: <Pine.LNX.4.58.0601152038540.19953@irie>
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com>
 <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com>
 <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org>
 <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Jan 2006 19:05:32.0808 (UTC) FILETIME=[A8A3F080:01C61A06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006, ext Stuffed Crust wrote:

>  * Knowing the hardware frequency capabilities, the 802.11 stack applies
>    802.11d and regdomain rules to the available frequency set, and
Regarding 802.11d and regulatory domains, the stack should also be able to
stick to one regulatory domain if asked so by userspace, whatever the APs
around tell us.

Cheers,
Samuel.
