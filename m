Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbUK0JOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUK0JOv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 04:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUK0JOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 04:14:50 -0500
Received: from canuck.infradead.org ([205.233.218.70]:4356 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261160AbUK0JOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 04:14:49 -0500
Subject: Re: 2.6.9-ac11 kernel crash with nvidia 6629
From: Arjan van de Ven <arjan@infradead.org>
To: viaprog@niif.vsu.ru
Cc: linux-kernel@vger.kernel.org, linux-bugs@nvidia.com,
       Sergey Kondratiev <serkon@box.vsi.ru>
In-Reply-To: <41A73850.3070400@lic1.vsi.ru>
References: <41A73850.3070400@lic1.vsi.ru>
Content-Type: text/plain
Message-Id: <1101546866.2641.4.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 27 Nov 2004 10:14:26 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> PREEMPT
> Modules linked in: nvidia vmnet vmmon


preempt, nvidia and vmware, and you're suprised things blow up?????
try to narrow it down but I suggest you keep this of lkml; binary module bugreports are basically off-topic.

