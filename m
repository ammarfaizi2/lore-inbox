Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbREBJzp>; Wed, 2 May 2001 05:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbREBJzf>; Wed, 2 May 2001 05:55:35 -0400
Received: from mail.scs.ch ([212.254.229.5]:37385 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S132516AbREBJz3>;
	Wed, 2 May 2001 05:55:29 -0400
Message-ID: <3AEFD943.8FE23199@scs.ch>
Date: Wed, 02 May 2001 11:54:11 +0200
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Alpha mailing list <linux-alpha@vger.rutgers.edu>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: serial console problems with 2.4.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just installed 2.4.4 on our alpha SMP boxes (ES40) and now I have
problems with the serial console:

sulogin does not accept input from the serial line
mingetty does not accept input from the serial line
agetty works fine

Everything works fine for the 2.4.2 kernel. I took the .config file from
the 2.4.2 kernel to compile the 2.4.4 kernel.

Any ideas?

Reto

