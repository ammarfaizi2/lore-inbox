Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267171AbUFZOet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267171AbUFZOet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 10:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267173AbUFZOet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 10:34:49 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:18915 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S267171AbUFZOer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 10:34:47 -0400
Date: Sat, 26 Jun 2004 16:34:41 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb == blank screen (Thinkpad r50p - FireGL T2 1600x1200 LCD)
Message-ID: <20040626143441.GH12482@louise.pinerecords.com>
References: <20040618154118.ED0D5106@damned.travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618154118.ED0D5106@damned.travellingkiwi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun-18 2004, Fri, 16:41 +0100
Hamie <hamish@travellingkiwi.com> wrote:

> I've just tried kernel 2.6.7 and radeonfb on my Thinkpad r50p, and sadly
> it doesn't seem to work as advertised. The display works fine in VGA 80x24
> on initial boot, but when the radeonfb initialises, I get a blank screen
> with just the cursor flashing back & forth at the bottom in time to
> whatever is supposedly supposed to be displayed.

Just compile radeonfb into the kernel directly and you'll be fine.

-- 
Tomas Szepe <szepe@pinerecords.com>
