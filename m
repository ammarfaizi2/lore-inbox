Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTAYR16>; Sat, 25 Jan 2003 12:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTAYR15>; Sat, 25 Jan 2003 12:27:57 -0500
Received: from [81.2.122.30] ([81.2.122.30]:1542 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261593AbTAYR15>;
	Sat, 25 Jan 2003 12:27:57 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301251737.h0PHbcZY001157@darkstar.example.net>
Subject: Re: [Corrected] Set2 scancodes for Japanese keyboard
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sat, 25 Jan 2003 17:37:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030125183001.F16711@ucw.cz> from "Vojtech Pavlik" at Jan 25, 2003 06:30:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, Jan 25, 2003 at 05:28:25PM +0000, John Bradford wrote:
> 
> > Some got missed off the first time:
> 
> What kernel this is tested with? What method used? These don't look like
> Set2 codes AT ALL.

The kernel is 2.4.20.  The keycode is the output from showkey, and the
make and break codes are the output from showkey -s.

Should I have used I8042_DEBUG_IO instead?  :-/

John.
