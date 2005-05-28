Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVE1Nrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVE1Nrr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 09:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVE1Nrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 09:47:47 -0400
Received: from zodiac.mimuw.edu.pl ([193.0.96.128]:33750 "EHLO
	students.mimuw.edu.pl") by vger.kernel.org with ESMTP
	id S262710AbVE1Nrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 09:47:45 -0400
Date: Sat, 28 May 2005 15:47:36 +0200
From: Marcin Bis <marcin.bis@students.mimuw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: problem with ALSA ane intel modem driver
Message-ID: <20050528154736.3ab2550a@laptop>
In-Reply-To: <200505280716.46688.cijoml@volny.cz>
References: <200505280716.46688.cijoml@volny.cz>
X-Mailer: Sylpheed-Claws 1.9.6cvs1 (GTK+ 2.6.4; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 May 2005 07:16:46 +0200
Michal Semler <cijoml@volny.cz> wrote:

> Hi,
> 
> for testing purposes I compiled 2.6.12-rc5 and my dmesg si full of 
> 
> codec_semaphore: semaphore is not ready [0x1][0x701300]
> codec_read 1: semaphore is not ready for register 0x54
> codec_semaphore: semaphore is not ready [0x1][0x701300]
> codec_write 1: semaphore is not ready for register 0x54
> codec_semaphore: semaphore is not ready [0x1][0x700300]
> codec_write 0: semaphore is not ready for register 0x2c
> 

Same problem on 2.6.11.11

Current Debian testing, 
(Intel Corp. 82801CA/CAM AC'97 Modem Controller)

-- 
 Marcin Bis
