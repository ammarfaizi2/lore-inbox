Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273721AbRI0R2V>; Thu, 27 Sep 2001 13:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273729AbRI0R2M>; Thu, 27 Sep 2001 13:28:12 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:4618 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S273721AbRI0R15>; Thu, 27 Sep 2001 13:27:57 -0400
Date: Thu, 27 Sep 2001 13:28:23 -0400
Message-Id: <200109271728.f8RHSNN08448@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
X-Also-Posted-To: linux.dev.kernel
Subject: Re: Fighting with K7VZA (via KT133A/686B): Any news?
In-Reply-To: <01092523011505.01149@localhost.localdomain>
Distribution: local
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01092523011505.01149@localhost.localdomain>,
Rob Landley <landley@trommello.org> wrote:

| Does the best course of action at this point involve attempting to get money 
| back, and if so, which motherboard can actually accept ~gigahertz athlon and 
| PC133 memory and possibly even do something useful with it under any known or 
| expected 2.4 kernel variant?

  I would certainly return the board ASAP. The chances are that you have
a defective example rather than a bad design, but you might want to be
prepared for a brand switch if the next one doesn't work. But see below...

| Thanks for your time.  (How much did Tom's Hardware get paid to recommend 
| this motherboard as "Rock Solid"?  What, Talc?  Pumice?  Sandstone?  Perhaps 
| a particularly flaky vein of mica?)

  I wouldn't say that even in jest. I sometimes question the competence
of those reviews, and often the relevance, but I think they're honest.

Possible causes:

  Power supply. BIOS option setting. Memory (memtest doesn't use the cpu
specific stuff to get the high data rate, at least my old copy).

Board I use:

  Abit KK266. With the Athlon optimization and 2.4.9ac14+patch. Runs
solid with 1GB RAM, high memory enabled, 1.4GHz CPU speed. And is stable
for 10% (146MHz FSB) o/c as well, so I think it's really stable.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
