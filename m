Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVKONTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVKONTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVKONTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:19:04 -0500
Received: from smtp.terra.es ([213.4.129.129]:59692 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S932491AbVKONTC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:19:02 -0500
Date: Tue, 15 Nov 2005 14:18:51 +0100
From: "Tue, 15 Nov 2005 14:18:51 +0100" <grundig@teleline.es>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051115141851.18c2c276.grundig@teleline.es>
In-Reply-To: <4379846E.2070006@wolfmountaingroup.com>
References: <58MJb-2Sn-37@gated-at.bofh.it>
	<58NvO-46M-23@gated-at.bofh.it>
	<58Rpx-1m6-11@gated-at.bofh.it>
	<58UGF-6qR-27@gated-at.bofh.it>
	<58UQf-6Da-3@gated-at.bofh.it>
	<437933B6.1000503@shaw.ca>
	<1132020468.27215.25.camel@mindpipe>
	<20051115032819.GA5620@redhat.com>
	<43795575.9010904@wolfmountaingroup.com>
	<20051115050658.GA13660@redhat.com>
	<43797E05.5090107@wolfmountaingroup.com>
	<17273.34218.334118.264701@cse.unsw.edu.au>
	<4379846E.2070006@wolfmountaingroup.com>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 14 Nov 2005 23:47:10 -0700,
"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribió:

> Great point, and you are correct that MS DOS had bigger stacks than 4K. 
> Onward through the fog ....


And Linux had stacks bigger than 4K until recently and could be made
bigger again. But 4K stacks are not considered a regression, but a
feature (ie: a good thing). So I guess you're not impressing lots 
of people saying that msdos had bigger stacks...
