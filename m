Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRJTQWx>; Sat, 20 Oct 2001 12:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273622AbRJTQWo>; Sat, 20 Oct 2001 12:22:44 -0400
Received: from ns.ithnet.com ([217.64.64.10]:34052 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273565AbRJTQWX>;
	Sat, 20 Oct 2001 12:22:23 -0400
Date: Sat, 20 Oct 2001 18:22:57 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB module ov511 dies after about 30 minutes
Message-Id: <20011020182257.513a36e7.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a webcam model creative webcam III. I read from it every minute. After
about 30 minutes the module ov511 cannot be unloaded anymore, stopped working
(of course, only black pictures are delivered) and there are no error messages
what so ever. This can only be resolved by rebooting. Any hints?
Used kernel 2.4.13-pre5.
Used to work with 2.4.10.

Regards,
Stephan
