Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTAIKeM>; Thu, 9 Jan 2003 05:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbTAIKeL>; Thu, 9 Jan 2003 05:34:11 -0500
Received: from mail.ithnet.com ([217.64.64.8]:3090 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264940AbTAIKeC>;
	Thu, 9 Jan 2003 05:34:02 -0500
Date: Thu, 9 Jan 2003 11:42:47 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: MB without keyboard controller / USB-only keyboard ?
Message-Id: <20030109114247.211f7072.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

how do I work with a mb that contains no keyboard controller, but has only USB
for keyboard and mouse?
While booting the kernel I get:

pc_keyb: controller jammed (0xFF)

(a lot of these :-)

and afterwards I cannot use the USB keyboard.
Everything works with a mb that contains a keyboard-controller, but where I use a
USB keyboard.

-- 
Regards,
Stephan
