Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262309AbREWGye>; Wed, 23 May 2001 02:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262423AbREWGyY>; Wed, 23 May 2001 02:54:24 -0400
Received: from nwcst320.netaddress.usa.net ([204.68.23.65]:13795 "HELO
	nwcst320.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S262309AbREWGyO> convert rfc822-to-8bit; Wed, 23 May 2001 02:54:14 -0400
Message-ID: <20010523065412.6796.qmail@nwcst320.netaddress.usa.net>
Date: 23 May 2001 00:54:12 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: __asm__
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
              I  am comfronting with a macro __asm__ . What is the meaning of
this. I cannot find the definition of this. I need the meaning of this line
 __asm__("and	1 %%esp.%0; ":"=r" (current) : "0" (~8191UL));

                       This is defined inside the get_current()	in current.h
Thanks in advance
                           by
                                     Blesson
          


____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
