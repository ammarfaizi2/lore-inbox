Return-Path: <linux-kernel-owner+w=401wt.eu-S936719AbWLKRms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936719AbWLKRms (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937072AbWLKRms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:42:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49256 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S936719AbWLKRmr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:42:47 -0500
Date: Mon, 11 Dec 2006 17:50:39 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Malte =?UTF-8?B?U2NocsO2ZGVy?= <MalteSch@gmx.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Benny Amorsen <benny+usenet@amorsen.dk>, linux-kernel@vger.kernel.org
Subject: Re: Window scaling problem?
Message-ID: <20061211175039.015305b2@localhost.localdomain>
In-Reply-To: <200612111829.49469.MalteSch@gmx.de>
References: <Pine.LNX.4.61.0612101001390.9675@yvahk01.tjqt.qr>
	<m33b7mhjfh.fsf@ursa.amorsen.dk>
	<Pine.LNX.4.61.0612111102230.11941@yvahk01.tjqt.qr>
	<200612111829.49469.MalteSch@gmx.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 18:29:44 +0100
Malte Schröder <MalteSch@gmx.de> wrote:

> Isn't window scaling something that the tcp-stacks on both ends of the 
> connection do? AFAIK the routers and firewalls that push the packets around 
> have nothing to do with it .. but I could be wrong ;)

Correct. You've just proved you are more qualified than some firewall
product designers. Some "firewall" products like to tamper with the TCP
stream however, or are just too stupid to parse options.

Alan
