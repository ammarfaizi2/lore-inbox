Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUCDIVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 03:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUCDIVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 03:21:43 -0500
Received: from styx.suse.cz ([82.208.2.94]:6272 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261537AbUCDIVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 03:21:42 -0500
Date: Thu, 4 Mar 2004 09:21:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Fremlin <john@fremlin.de>
Cc: Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: Using physical extents instead of logical ones for NEC USB HID gamepads
Message-ID: <20040304082140.GC489@ucw.cz>
References: <86y8vcygar.fsf@notus.ireton.fremlin.de> <20031023001850.GB9808@phunnypharm.org> <87ptgolq69.fsf@bayu.ireton.fremlin.de> <87y8qo4u9h.fsf_-_@bayu.ireton.fremlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8qo4u9h.fsf_-_@bayu.ireton.fremlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 11:49:30AM +0000, John Fremlin wrote:

> This patch for 2.4.22 (which applied cleanly to 2.4.25-pre) adds the
> ID 073e:0301 NEC, Inc. Game Pad to the list of quirky USB joypads which
> mix up logical and physical extents.
> 
> Please apply as the joypad obviously does not work without it. I've
> tested it.

Applied to 2.6, for 2.4 please send it to Greg KH, and tell him I agree
with the patch.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
