Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135986AbREDJNT>; Fri, 4 May 2001 05:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135987AbREDJNJ>; Fri, 4 May 2001 05:13:09 -0400
Received: from pec-89-74.tnt6.b2.uunet.de ([149.225.89.74]:260 "HELO
	sonne.glowinginthesun") by vger.kernel.org with SMTP
	id <S135986AbREDJMw>; Fri, 4 May 2001 05:12:52 -0400
Date: Fri, 4 May 2001 10:12:19 +0200
From: Hendrik Volker Brunn <hvb@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: pdc20267 both channels share one IRQ
Message-ID: <20010504101219.A300@sonne.glowinginthesun>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it ok for an Promise Ultra 100 to have both channels
assigned the same IRQ?

I have one DTLA-307030 attached as master to each channel
and get transfer rates at around 12 - 16 MB/s.
As I have heard people reporting transfer rates of about 24 - 28 MB/s
I was wondering if there were some connections.

Is it me just being dumb and ignoring obvious facts or something 
misconfigured weirdly with my system?

Hendrik

I'm subscribed.

-- 
"And I'm right. I'm always right, but in this case I'm just a bit more
right than I usually am" -- Linus Torvald, Sunday Aug 27, 2000.
## Linux 2.4.4 running on an i586 ##
