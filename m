Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276577AbRI2SbT>; Sat, 29 Sep 2001 14:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276578AbRI2SbA>; Sat, 29 Sep 2001 14:31:00 -0400
Received: from mx7.port.ru ([194.67.57.17]:57079 "EHLO mx7.port.ru")
	by vger.kernel.org with ESMTP id <S276577AbRI2San>;
	Sat, 29 Sep 2001 14:30:43 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109292253.f8TMrMG14132@vegae.deep.net>
Subject: 2.4.10 - cerberized OK
To: linux-kernel@vger.kernel.org
Date: Sun, 30 Sep 2001 02:53:21 +0400 (MSD)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

          Okay folks, seems like the days when non-ac`ed 2.4
    died after 15s of cerberus are gone... ;-)
       Today i made a 13h50m cerberization and it was pretty stable...
       Also i made a ac16 test, and i realised that ac16 was _much_ more
    responsive! Actually 2.4.10 have 70% cpu free (p166/24) and
    ttyS0-bound irc client (epic) stalled so much, that i hate it...
    2.4.9-ac16 was more or less sane in these terms (1-2 sec max stalls)
    But actually i ran it only for 1.5 hurs on ac16, so ...


cheers, Samium Gromoff
