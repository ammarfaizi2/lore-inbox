Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135880AbRDYPQs>; Wed, 25 Apr 2001 11:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135882AbRDYPQi>; Wed, 25 Apr 2001 11:16:38 -0400
Received: from pop.gmx.net ([194.221.183.20]:63790 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135880AbRDYPQ2>;
	Wed, 25 Apr 2001 11:16:28 -0400
Message-ID: <3AE6EBCC.429B9449@gmx.at>
Date: Wed, 25 Apr 2001 17:22:53 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeroen Geusebroek <Jeroen.Geusebroek@intellit.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE Raid supported with the HPT370?
In-Reply-To: <NCBBJKHJIKHIFECNNOAMIECEEDAA.Jeroen.Geusebroek@intellit.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeroen Geusebroek wrote:
> I have ordered a ABIT VP6 motherboard with the HPT370 controller
> and would like to know if raid0 is supported with linux?
> 
> If not, will i be able to work without raid then? (maybe using
> software raid)

The controller is working fine, but the raid functionality is not
working within linux. Of course you could use the linux software raid.
However in this case you cannot install another OS on the HPT if this
uses the hpt raid.
I have written a small module which does raid 0 in the hpt way of life.
You can send me an email if you want to try it out. The future of my mod
is unknown because of the IDE guys want to support the ata raids. So it
might become obsolete.

good luck,
Wilfried

-- 
Wilfried Weissmann ( mailto:Wilfried.Weissmann@gmx.at )
Mobile: +43 676 9444465
