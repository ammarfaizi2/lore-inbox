Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318093AbSHHW1X>; Thu, 8 Aug 2002 18:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318092AbSHHW1X>; Thu, 8 Aug 2002 18:27:23 -0400
Received: from mailhost1-chcgil.chcgil.ameritech.net ([206.141.192.67]:57023
	"EHLO mailhost.chi1.ameritech.net") by vger.kernel.org with ESMTP
	id <S318093AbSHHW1W>; Thu, 8 Aug 2002 18:27:22 -0400
Date: Thu, 8 Aug 2002 17:31:33 -0500
From: Mark J Roberts <mjr@znex.org>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net, vojtech@suse.cz
Subject: USBLP_WRITE_TIMEOUT too short for Kyocera FS-1010.
Message-ID: <20020808223133.GA3776@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Key: 0x025D0C28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Printing complicated postscript documents makes my Kyocera FS-1010
hit that timeout. I increased it to 240 seconds and the problem
seems to have disappeared.

I guess there ought to be a blacklist or something.
