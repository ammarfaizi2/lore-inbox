Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTAIBLY>; Wed, 8 Jan 2003 20:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTAIBLX>; Wed, 8 Jan 2003 20:11:23 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:932 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261286AbTAIBLX>; Wed, 8 Jan 2003 20:11:23 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Embed __this_module in module itself.
References: <20021227104328.143DD2C05D@lists.samba.org>
	<buou1gma6bz.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<buoadid1pxl.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030108205645.GA4037@mars.ravnborg.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 09 Jan 2003 10:18:53 +0900
In-Reply-To: <20030108205645.GA4037@mars.ravnborg.org>
Message-ID: <buoy95vrugy.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:
> Not knowing much about v850, I wonder why you do not need to set the -m
> option. Most other architectures do this.

???

A far as I can see, no architecture does anything different than the
default.

[Why on earth would -m be needed, anyway?]

-Miles
-- 
Fast, small, soon; pick any 2.
