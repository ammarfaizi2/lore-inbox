Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSEaFwL>; Fri, 31 May 2002 01:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSEaFwK>; Fri, 31 May 2002 01:52:10 -0400
Received: from gherkin.frus.com ([192.158.254.49]:36736 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S315091AbSEaFwK>;
	Fri, 31 May 2002 01:52:10 -0400
Message-Id: <m17DfKc-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.19: vesafb problems
To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2002 00:52:10 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't going to be much of a bug report :-(.  Attempting to boot
2.5.19 with "vga = 791" in /etc/lilo.conf hangs with a blank black
screen right at the point where the display attempts to switch video
modes.  Works fine for 2.5.18 and prior kernels.  Booting 2.5.19 in
standard 80x25 text mode works fine also.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
