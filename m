Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270183AbTGPJx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 05:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270196AbTGPJx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 05:53:58 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:26052 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S270183AbTGPJx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 05:53:57 -0400
Message-ID: <20030716100841.48619.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Il Skurko" <a_very@mad.scientist.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Jul 2003 05:08:41 -0500
Subject: Thinkpad T23: linux 2.5.x/2.6.0-test won't boot
X-Originating-Ip: 213.65.215.127
X-Originating-Server: ws1-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange problem that I cannot seem to
find the answer to. 2.4.x works great on my
T23, but I have still not been able to boot
2.5.x properly. I just tried 2.5.75 and the 2.6.0-test.
Not even with a "make allnoconfig", and then
adding just the bare minimum, like IDE support.
I have a good experience from configuring 2.4.x
for T23, so I believe I know what needs to be
included for it to work.

After selecting the kernel in the grub menu,
it only gets as far as to writing "Decompressing kernel...
Booting kernel.". Then there is no more text
output. The harddisk led indicates it continues
with something though, but it does not respond
to keyboard input (so I have to swith the computer
off).

Sorry to bother you with this, but perhaps it turns
out to be important for finding some bug. Please
CC me with any replies to this. Rgds /Per

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers

