Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTICHtF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTICHtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:49:05 -0400
Received: from news.cistron.nl ([62.216.30.38]:7947 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261486AbTICHtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:49:03 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Date: Wed, 3 Sep 2003 07:49:02 +0000 (UTC)
Organization: Cistron
Message-ID: <bj46de$inp$1@news.cistron.nl>
References: <bj447c$el6$1@news.cistron.nl> <20030903074013.GA13773@k3.hellgate.ch>
X-Trace: ncc1701.cistron.net 1062575342 19193 62.216.30.38 (3 Sep 2003 07:49:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi  <rl@hellgate.ch> wrote:
>> vanilla 2.6.0-test4 & test4-mm[45] & the onboard ethernet doesn't seem to work.
>Try a kernel without ACPI and/or APIC support.

Yup, adding acpi=off "fixed" the problem.
Will wait for "better" times ! ;-)

Zanks!

Danny

-- 
I think so Brain, but why does a forklift 
have to be so big if all it does is lift forks?

