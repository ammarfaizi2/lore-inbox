Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267774AbTAIT4V>; Thu, 9 Jan 2003 14:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267888AbTAIT4U>; Thu, 9 Jan 2003 14:56:20 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:56962 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267774AbTAIT4U>;
	Thu, 9 Jan 2003 14:56:20 -0500
Date: Thu, 9 Jan 2003 21:04:29 +0100
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Joshua Kwan <joshk@ludicrus.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54-dj1-bk] Some interesting experiences...
Message-ID: <20030109200428.GB3345@gagarin>
References: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx> <20030108015107.GA2170@gagarin> <20030108095253.B23278@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095253.B23278@ucw.cz>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18Wiuj-0002GN-00*t3k6zA9lkmA* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 09:52:53AM +0100, Vojtech Pavlik wrote:
> 
> That I'd like to know, too. In the worst case, we can make the timeout
> be half a second, or more - it'd just mean that for a resync you would
> have to not touch the mouse this long if really a byte is lost.

Still havn't misbehaved here with the extended timeout. So it seems that it
really helped.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
