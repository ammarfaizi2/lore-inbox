Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269206AbRHQASw>; Thu, 16 Aug 2001 20:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269226AbRHQASm>; Thu, 16 Aug 2001 20:18:42 -0400
Received: from www.ccsi.com ([216.236.168.10]:28866 "EHLO ccsi.com")
	by vger.kernel.org with ESMTP id <S269186AbRHQAS1>;
	Thu, 16 Aug 2001 20:18:27 -0400
Message-Id: <200108170013.f7H0DoO21290@ccsi.com>
Content-Type: text/plain; charset=US-ASCII
From: leroyljr <leroyljr@ccsi.com>
Reply-To: leroyljr@ccsi.com
To: linux-kernel@vger.kernel.org
Subject: Failure to Compile AIC7xxx Driver
Date: Thu, 16 Aug 2001 19:15:38 -0500
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If nobody has brought this up yet, I want to report this issue.

Here is what happened when I tried to build the aic7xxx driver for 2.4.9:

aicasm/aicasm_scan.l: In function `yylex':
aicasm/aicasm_scan.l:115: `T_VERSION' undeclared (first use in this function)
aicasm/aicasm_scan.l:115: (Each undeclared identifier is reported only once
aicasm/aicasm_scan.l:115: for each function it appears in.)
aicasm/aicasm_scan.l:132: `T_STRING' undeclared (first use in this function)

This is for the new driver, BTW.

If this has already been brought up, sorry for being redudant.  Send flames 
and letter bombs to my address.
