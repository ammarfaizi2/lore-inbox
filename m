Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310516AbSCEHmQ>; Tue, 5 Mar 2002 02:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSCEHmH>; Tue, 5 Mar 2002 02:42:07 -0500
Received: from selui2.tetrapak.com ([195.163.136.92]:18892 "EHLO
	selui2.tetrapak.com") by vger.kernel.org with ESMTP
	id <S310516AbSCEHls>; Tue, 5 Mar 2002 02:41:48 -0500
Message-ID: <154A5E546927D51197A200508BE1DEE983F2A0@chlaexh01.la.ch.tetrapak.com>
From: Cuendet JeanEric <JeanEric.Cuendet@tetralaval.com>
To: linux-kernel@vger.kernel.org
Subject: Disk IO Statistics (/proc/stat)
Date: Tue, 5 Mar 2002 08:41:41 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I never coded for linux kernel so I need little help to begin.

I'd like to change the way disk IO is accounted : Is someone already working
on this thing?

I'll do a hashmap structure containing the disks IO stats.
How do we do a hashmap in the linux kernel?
Is it the *good* way to go?

Thanks
-jec

PS: I'm not in the list, so please CC me.
