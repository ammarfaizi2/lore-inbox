Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUJZSpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUJZSpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUJZSpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:45:03 -0400
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:33960 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261366AbUJZSo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:44:58 -0400
Subject: Re: Framebuffer problem.
From: Arnaud Ligot <spyroux@spyroux.be>
To: "Olavo B D'Antonio" <olavobdantonio@ig.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41733238.4010409@ig.com.br>
References: <41733238.4010409@ig.com.br>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 20:44:54 +0200
Message-Id: <1098816294.6475.18.camel@chatPotte.home.spyroux.be>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Mon, 2004-10-18 at 01:02 -0200, Olavo B D'Antonio wrote:
> Hi,
>    
>     I changed my GeForce FX 5200 128MB to  another GeForce FX5200 but 
> with 256MB of memory, and something had been wrong. At boot, framebuffer 
> return a error:
>     vesafb: probe of vesafb0 failed with error -6
same error here (Linux chatPotte 2.6.8.1 #2 SMP Thu Sep 16 06:38:51 CEST
2004 i686 Intel(R) Pentium(R) 4 CPU 3.40GHz GenuineIntel GNU/Linux) 
(SMP with the HT Scheduler)

I never tried with a newer kernel... I could do that during this week if
you want.

I only managed to get a framebuffer with the vga driver :-/ 

I have the same card but sold in an ASUS box.

-- (from cat /proc/pci)
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200]
(rev 161).
      IRQ 16.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].

A.

-- 
Arnaud Ligot <spyroux@spyroux.be>

