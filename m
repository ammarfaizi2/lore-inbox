Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbTBZSF3>; Wed, 26 Feb 2003 13:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268862AbTBZSF3>; Wed, 26 Feb 2003 13:05:29 -0500
Received: from grieg.holmsjoen.com ([206.124.139.154]:55566 "EHLO
	grieg.holmsjoen.com") by vger.kernel.org with ESMTP
	id <S268861AbTBZSEt>; Wed, 26 Feb 2003 13:04:49 -0500
Date: Wed, 26 Feb 2003 10:15:04 -0800
From: Randolph Bentson <bentson@grieg.holmsjoen.com>
To: linux-kernel@vger.kernel.org
Subject: Starmode Radio IP
Message-ID: <20030226101504.A9593@grieg.holmsjoen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble with STRIP in 2.4.20.  While I can configure
and use it (sometimes), I cannot shutdown operation by killing
the slattach process.  The kernel reports that there are still
open references to the device, even after "ifconfig...down" is
performed.

Are there folks out there using this feature with whom I might
discuss this further?

-- 
Randolph Bentson
bentson@holmsjoen.com
