Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVCALwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVCALwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVCALwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:52:19 -0500
Received: from styx.suse.cz ([82.119.242.94]:44502 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261881AbVCALwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:52:16 -0500
Date: Tue, 1 Mar 2005 12:54:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: "Ian E. Morgan" <imorgan@webcon.ca>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALPS tapping disabled. WHY?
Message-ID: <20050301115432.GA5598@ucw.cz>
References: <Pine.LNX.4.62.0502241822310.8449@light.int.webcon.net> <200502242208.16065.dtor_core@ameritech.net> <20050227075041.GA1722@ucw.cz> <Pine.LNX.4.62.0502281721210.21033@light.int.webcon.net> <422454A5.7070206@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422454A5.7070206@blue-labs.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 06:40:21AM -0500, David Ford wrote:
> I would also appreciate the return of good resolution.  Blocky mouse 
> startup moves make graphic editing rather difficult.  No mouse movement 
> until I have moved my finger a significant distance then the mouse all 
> of a sudden jumps a dozen pixels before it "smoothly" glides along.
> 
> I would also love to see the sync issues go away. :/  Whatever this 
> patch(es) was supposed to accomplish, it introduced some rather 
> undesirable side effects.  a) sync issues, b) tapping, c) fine grain 
> movements, d) loss of scroll sliding as well (moving your finger along 
> the side/bottom of the glidepoint).
> 
> Not griping, just providing feedback.
 
Can you check with a current -mm kernel whether any of the issues is
still there? Everything seems to work smoothly with my ALPS.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
