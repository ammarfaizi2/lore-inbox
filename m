Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVCWNiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVCWNiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVCWNiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:38:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27598 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261459AbVCWNiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:38:21 -0500
Date: Wed, 23 Mar 2005 14:38:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: aq <aquynh@gmail.com>
cc: Natanael Copa <mlists@tanael.org>,
       "Hikaru1@verizon.net" <Hikaru1@verizon.net>,
       linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
In-Reply-To: <9cde8bff05032305044f55acf3@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503231436550.10048@yvahk01.tjqt.qr>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>  <20050322112628.GA18256@roll>
  <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>  <20050322124812.GB18256@roll>
 <20050322125025.GA9038@roll>  <9cde8bff050323025663637241@mail.gmail.com> 
 <1111581459.27969.36.camel@nc> <9cde8bff05032305044f55acf3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>If so, forkbomb doesnt cause much problem like they said, since
>eventually it would be killed once it reach the limit of memory. the
>system will recover automatically after awhile.

I doubt that! Maybe OOM strikes one process out, but as already said, when 
that happens, it makes room for further spawns.



Jan Engelhardt
-- 
