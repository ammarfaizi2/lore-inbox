Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269431AbRHCP5u>; Fri, 3 Aug 2001 11:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269432AbRHCP5k>; Fri, 3 Aug 2001 11:57:40 -0400
Received: from nwcst31f.netaddress.usa.net ([204.68.23.61]:136 "HELO
	nwcst31f.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S269431AbRHCP50> convert rfc822-to-8bit; Fri, 3 Aug 2001 11:57:26 -0400
Message-ID: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>
Date: 3 Aug 2001 09:57:34 MDT
From: Andrey Ilinykh <ailinykh@usa.net>
To: linux-kernel@vger.kernel.org
Subject: fake loop
X-Mailer: USANET web-mailer (M3.4.JUL00)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Very often I see in kernel such code as
do {
  dosomthing();
} while(0);

or even

#define prepare_to_switch()     do { } while(0)

Who can explain me a reason for these fake loops?
Thank you,
  Andrey

