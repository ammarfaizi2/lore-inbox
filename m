Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266087AbRF2OSC>; Fri, 29 Jun 2001 10:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266088AbRF2ORn>; Fri, 29 Jun 2001 10:17:43 -0400
Received: from nwcst294.netaddress.usa.net ([204.68.23.39]:19911 "HELO
	nwcst294") by vger.kernel.org with SMTP id <S266087AbRF2ORg> convert rfc822-to-8bit;
	Fri, 29 Jun 2001 10:17:36 -0400
Message-ID: <20010629141734.24679.qmail@nwcst294>
Date: 29 Jun 2001 08:17:34 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Re: Delay eth0 initilization]
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Generally that message means you have not compiled or installed the
module for your network card, or the "alias eth0 ..." line in
/etc/conf.modules is wrong or missing.  If your system worked with the
old kernel, the former is more likely."

                       I did not make any changes in menuconfig. Does the
above alias eth0 comes defaultly
                          by
                         Blesson
