Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVFTRIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVFTRIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVFTRIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:08:55 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:54211 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261209AbVFTRIx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:08:53 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Rafael =?iso-8859-1?q?Rodr=EDguez?= <apt-drink@gulic.org>
Subject: Re: 2.6.12: codec_semaphore: semaphore is not ready
Date: Mon, 20 Jun 2005 18:09:15 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200506191402.02287.apt-drink@gulic.org> <s5hy895p8gg.wl%tiwai@suse.de> <200506201446.20541.apt-drink@gulic.org>
In-Reply-To: <200506201446.20541.apt-drink@gulic.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506201809.15739.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 Jun 2005 14:46, Rafael Rodríguez wrote:
> Takashi Iwai wrote:
> > If it's snd-intel8x0m (modem), you can ignore it unless you use the
> > drvier indeed.  If it's the former one (audio), it might be an ACPI
> > problem.  Try to tune acpi/pci boot option.
>
> Removed the snd-intel8xm, the message hasn't appeared again. So it seems
> that can be safely ignored (at least by me).

I've found that my snd-intel8x0m modem works fine despite the codec_semaphore 
warnings, so I think it can be ignored by the majority. This also isn't a 
2.6.12 problem, it's been happening for ages.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
