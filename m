Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269112AbRG3Wxh>; Mon, 30 Jul 2001 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269129AbRG3WxS>; Mon, 30 Jul 2001 18:53:18 -0400
Received: from venus.Sun.COM ([192.9.25.5]:34951 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S269126AbRG3Ww7>;
	Mon, 30 Jul 2001 18:52:59 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <2b13928a5c.28a5c2b139@mysun.com>
Date: Tue, 31 Jul 2001 00:43:38 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: eepro100 2.4.7-ac3 problems (apm related)
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

The eepro100 interface in my Fujitsy/Siemens Lifebook S-4546
won't come up after a suspend, if I unload the module and load it again
it works fine...
"ioctl SIOCSIFFLAGS: No such device" is the error message.

This happend in 2.4.5 i think.

/Pawel


