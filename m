Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312444AbSC3Lm7>; Sat, 30 Mar 2002 06:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSC3Lmu>; Sat, 30 Mar 2002 06:42:50 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:51389 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312444AbSC3Lml>;
	Sat, 30 Mar 2002 06:42:41 -0500
Date: Sat, 30 Mar 2002 12:42:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: martin@dalecki.de
Subject: Anyone with an ICH2 or ICH3 Intel southbridge and UDMA133 harddrive willing to test?
Message-ID: <20020330124208.A537@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think it should be possible to make the ICH2 and ICH3 Intel chips
(82801BA and 82801CA) do UDMA133. (Intel only says they can do UDMA100).
If anyone running a 2.5 kernel with an Intel mainboard with one of those
chips and a UDMA133 capable harddrive is willing to test this, please
contact me, I'll give you a patch.

-- 
Vojtech Pavlik
SuSE Labs
