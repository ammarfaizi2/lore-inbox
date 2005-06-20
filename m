Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFTPVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFTPVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVFTPVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:21:52 -0400
Received: from smtp.telefonica.net ([213.4.129.135]:43727 "EHLO
	telesmtp3.mail.isp") by vger.kernel.org with ESMTP id S261314AbVFTPVr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:21:47 -0400
From: Rafael =?iso-8859-1?q?Rodr=EDguez?= <apt-drink@gulic.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12: codec_semaphore: semaphore is not ready
Date: Mon, 20 Jun 2005 14:46:19 +0100
User-Agent: KMail/1.8.1
References: <200506191402.02287.apt-drink@gulic.org> <s5hy895p8gg.wl%tiwai@suse.de>
In-Reply-To: <s5hy895p8gg.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506201446.20541.apt-drink@gulic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> If it's snd-intel8x0m (modem), you can ignore it unless you use the
> drvier indeed.  If it's the former one (audio), it might be an ACPI
> problem.  Try to tune acpi/pci boot option.

Removed the snd-intel8xm, the message hasn't appeared again. So it seems that 
can be safely ignored (at least by me).

Thank you very much,

Rafael Rodríguez
