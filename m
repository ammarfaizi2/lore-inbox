Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132743AbRDQQbn>; Tue, 17 Apr 2001 12:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132754AbRDQQbd>; Tue, 17 Apr 2001 12:31:33 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:38153 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S132743AbRDQQbT>; Tue, 17 Apr 2001 12:31:19 -0400
Date: Tue, 17 Apr 2001 17:30:46 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: RobertoNibali <ratz@tac.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <3ADC6C70.1590D9B7@tac.ch>
Message-ID: <Pine.LNX.4.21.0104171727300.4446-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, RobertoNibali wrote:

> My 2 questions are: 
> Is this an acceptable fix for Donald? Because if so, I'd like to submit it
> for the starfire quardboard driver.

I have no idea - I haven't been able to get in touch with him :(
(The fix was urgently required, and this did the job).

> Is there no implication with PCI latencies if multiple such cards
> are loaded? I'm still having problems initializing more then 4
> Quadboards.

Not sure - I've never tried initing more than 3 of the DP83815 cards in a
single machine.  (I am using Cobalt Qube 3's, which have 2 DP83815's on
the motherboard, and a single PCI slot which I have installed a DP38315 in
for testing purposes).

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


