Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVJOCY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVJOCY4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 22:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVJOCY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 22:24:56 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:62145 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1750969AbVJOCYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 22:24:55 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: Forcing an immediate reboot
Date: Sat, 15 Oct 2005 02:24:51 +0000 (UTC)
Organization: Cistron
Message-ID: <dipp9j$mdp$1@news.cistron.nl>
References: <43505F86.1050701@perkel.com>
X-Trace: ncc1701.cistron.net 1129343091 22969 62.216.30.70 (15 Oct 2005 02:24:51 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel  <marc@perkel.com> wrote:
>Is there any way to force an immediate reboot as if to push the reset 
>button in software? Got a remote server that i need to reboot and 
>shutdown isn't working.

reboot -nf

Doesn't sync
just plain reboot


Danny

