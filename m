Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTAIITN>; Thu, 9 Jan 2003 03:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTAIITN>; Thu, 9 Jan 2003 03:19:13 -0500
Received: from main.gmane.org ([80.91.224.249]:36816 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261900AbTAIITM>;
	Thu, 9 Jan 2003 03:19:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Andres Salomon" <dilinger@voxel.net>
Subject: 2.5.x inspiron touchpad breakage
Date: Thu, 09 Jan 2003 03:27:54 -0500
Message-ID: <pan.2003.01.09.08.27.53.688647@voxel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.54 and 2.5.55 do not appear to initialize the touchpad on my Dell
Inspiron 3800.  No mouse device is detected until I plug a normal ps/2
mouse into the laptop.  I assume this is some weird bios thing.  2.4.x
works fine with it.  Does anyone have suggestions about where to look for
any changed in the 2.5 series that might've broken it, or any patches that
fix it?

