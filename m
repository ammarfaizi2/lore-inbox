Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293373AbSCJXED>; Sun, 10 Mar 2002 18:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293375AbSCJXDy>; Sun, 10 Mar 2002 18:03:54 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:52610 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id <S293373AbSCJXDj>;
	Sun, 10 Mar 2002 18:03:39 -0500
Message-ID: <3C8BE68B.4619BA83@yahoo.com>
Date: Sun, 10 Mar 2002 17:04:43 -0600
From: Max Valdez <maxvaldez@yahoo.com>
X-Mailer: Mozilla 4.78 [es] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Anybody succesfully compiled a CD-R capable 2.4.x kernel? 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I guess someone else did a similar question, but i didn't saw any good
answer.

Has anybody tried to compile a 2.4.x with cd burning  capabilities?, I
have a HP 8230 CD-R usable with RH 7.2 kernels, but when i try to
upgrade to a bigger version (say 1.4.8 or 9pre2-ac4)  The drive is not
recognized, not at boot nor when connected on running system.

I don't know if I'm missing some label on make config, i set scssi
emulation, even the cd-r 82** module for the cd burner, and of course
USB needed flags too.

Anyone have any advice for me?, I have even used a google found how-to,
but nothing have worked in a couple of month of trials.

Max

