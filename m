Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTJSRCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTJSRCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:02:35 -0400
Received: from 82-68-107-172.dsl.in-addr.zen.co.uk ([82.68.107.172]:3461 "EHLO
	brain.pulsesol.com") by vger.kernel.org with ESMTP id S261869AbTJSRCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:02:34 -0400
Date: Sun, 19 Oct 2003 18:02:35 +0100
From: Antony Gelberg <antony@antgel.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Silicon Image 3112
Message-ID: <20031019170235.GA1335@brain.pulsesol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to get my SIL3112 RAID controller to work.  It's in an ASUS
A7N8X mobo.  I'd like to boot from a RAID 1 array.

I've built silraid into the kernel (2.4.22), but on boot I get:
driver for Silicon Image Medley 0.0.1: no raid array found.

My two drives are detected as /dev/hda and /dev/hdc.  I _have_ set up
the array in the SIL BIOS.

If anyone can guide me on this, I'd be very grateful.  As I would be for
a CC, as I'm not subscribed.

A
-- 
Now playing: Spock's Beard - A Guy Named Sid: pt. III - You Don't Know
