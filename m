Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280801AbRLOF4n>; Sat, 15 Dec 2001 00:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281908AbRLOF4e>; Sat, 15 Dec 2001 00:56:34 -0500
Received: from china.patternbook.com ([216.254.75.60]:516 "EHLO
	china.patternbook.com") by vger.kernel.org with ESMTP
	id <S280801AbRLOF4X>; Sat, 15 Dec 2001 00:56:23 -0500
Date: Sat, 15 Dec 2001 00:56:41 -0500
From: Whit Blauvelt <whit@transpect.com>
To: linux-kernel@vger.kernel.org
Subject: Oops - 2.4.17rc1 (with iptables 2.4.6)
Message-ID: <20011215005641.A810@china.patternbook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out it didn't leave a trace in the logs, but had a hard Oops less than
an hour into running this on a box that's been rock-solid stable for a
couple years, most recently running 2.2.19. 

Sorry I didn't hand copy the Oops screen - no time for that. Back to 2.2.19.
So this isn't so useful a report, except maybe to caution going beyond the
"rc" stage too soon on this one, just in case.

The iptables patch applied to it was just with the standard features,
nothing experimental.

Whit
