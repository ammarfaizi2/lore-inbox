Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbVKRSfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbVKRSfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVKRSfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:35:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11397 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161068AbVKRSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:35:23 -0500
Subject: Re: 2.6.14-mm1 libata pata_via
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sander@humilis.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051116144825.GA16750@favonius>
References: <6397E994-0BC3-445F-BF2B-CD3D0ADB0E02@bootc.net>
	 <20051108121318.GB23549@favonius>
	 <1131455213.25192.26.camel@localhost.localdomain>
	 <20051116144825.GA16750@favonius>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Nov 2005 19:07:19 +0000
Message-Id: <1132340839.25914.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-16 at 15:48 +0100, Sander wrote:
> (2.6.14-mm2, Epia MII 10000, Maxtor 250GB pata).

mm2 has some buggy changes to the via driver versus mm1 (my fault not
Jeffs). I've been travelling so now I'm back I'll send some patches once
I've finished the more urgent things on the todo list (like writing the
presentation for Monday ;))


