Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUCQOOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 09:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUCQOOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 09:14:06 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:40165 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261462AbUCQOOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 09:14:03 -0500
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.5-rc1-mm1 reboots before the boot completes
Date: Wed, 17 Mar 2004 14:14:02 +0000 (UTC)
Organization: Cistron
Message-ID: <c39mfa$t9$1@news.cistron.nl>
References: <20040316015338.39e2c48e.akpm@osdl.org> <405823B2.7070500@aitel.hist.no>
X-Trace: ncc1701.cistron.net 1079532842 937 62.216.30.38 (17 Mar 2004 14:14:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting  <helgehaf@aitel.hist.no> wrote:
>2.6.5-rc1-mm1 didn't come up for me. It loads, prints a few
>early messages.  Then there is a video mode switch as it
>brings up the radeon fb console. The pc reboots before the
>flatscreen has time to sync, so I don't know exactly where it
>goes wrong.  I might be able to try a CRT, they sync faster.
>The 2.6.4-mm1 kernel works fine for me, with the same
>config (including 4k stacks)

2 machines:
VIA-C3 mini-itx: boots with 2.6.5-rc1-mm1 chokes on 2.6.4-mm2
AMD64/3200     : boots with 2.6.4-mm2     chokes on 2.6.5-rc1-mm1

:-)))

Danny

-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

