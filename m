Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311618AbSDNFrw>; Sun, 14 Apr 2002 01:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311641AbSDNFrv>; Sun, 14 Apr 2002 01:47:51 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:2372 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S311618AbSDNFrv>; Sun, 14 Apr 2002 01:47:51 -0400
From: brian@worldcontrol.com
Date: Sat, 13 Apr 2002 22:41:41 -0700
To: linux-kernel@vger.kernel.org
Subject: Is 2.4.19-pre5-ac3 destroying my laptop?
Message-ID: <20020414054141.GA1867@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of us with Sony FXA laptops have noticed our computers becoming
rather hot.

I'm running linux 2.4.19-pre5-ac3 and I've tried both ACPI w/acpid and
APM w/lvcool, and there are occasions where the laptop becomes so hot
that I turn it off.

If I power back on, the BIOS immediately turns the fan on.

When running with ACPI I'm using acpid-20010510.tar.gz.

Any pointers that would help diagnose this problem before I or
others fry CPUs would be appreciated.

-- 
Brian Litzinger <brian@worldcontrol.com>
