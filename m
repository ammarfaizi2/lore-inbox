Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUFGLuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUFGLuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUFGLuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:50:17 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14722 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S264405AbUFGLuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:50:14 -0400
Date: Mon, 7 Jun 2004 13:50:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: [patches] Input update
Message-ID: <20040607115022.GA12072@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These patches fix various bugs, and update a few input drivers. They've
all been in Andrew's tree for a while. My current input tree has a bunch
more changes, but I'd like them to get some more testing first.

Please apply the patches or pull from

	bk://kernel.bkbits.net/vojtech/input-for-linus

Thanks,
-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
