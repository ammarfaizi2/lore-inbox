Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266586AbRHAKu1>; Wed, 1 Aug 2001 06:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266580AbRHAKuR>; Wed, 1 Aug 2001 06:50:17 -0400
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:50160 "HELO
	duron.intern.kubla.de") by vger.kernel.org with SMTP
	id <S266583AbRHAKuI>; Wed, 1 Aug 2001 06:50:08 -0400
Date: Wed, 1 Aug 2001 12:49:56 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        christophe barb? <christophe.barbe@lineo.fr>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Virii on vger.kernel.org lists
Message-ID: <20010801124956.B2154@intern.kubla.de>
In-Reply-To: <Pine.LNX.4.33.0107311858360.23876-100000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107311858360.23876-100000@infradead.org>
User-Agent: Mutt/1.3.18i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2001 at 07:02:18PM +0100, Riley Williams wrote:

> Is there any way we can set up an automatic virus scan of all
> attachments at vger, and have it deal with any virii at source?

Yes: www.amavis.org

> Come to that, is there a decent Linux-based virus scanner around?

The german antivirus tool AntiVir is free for personal use (www.free-av.com)
and i am pretty sure they would sponsor a version for the list server if asked
(if linux-kernel would be considered commercial use).

But even better would be to also use the procmail sanitizer:
  ftp://ftp.rubyriver.com/pub/jhardin/antispam/procmail-security.html

It does not scan for virii but defangs attachments and html tags so that
braindamaged apps would not automatically execute the required interpreter
for the virus.

Dominik Kubla
-- 
ScioByte GmbH, Zum Schiersteiner Grund 2, 55127 Mainz (Germany)
Phone: +49 6131 550 117  Fax: +49 6131 610 99 16

GnuPG: 717F16BB / A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
