Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTD3M0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTD3M0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:26:44 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:36414 "EHLO
	mwinf0503.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262143AbTD3M0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:26:43 -0400
Date: Wed, 30 Apr 2003 14:38:58 +0200
Subject: Re: PATCH: usb-uhci: interrupt out with urb->interval 0  [linux-usb-devel]
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Arjan Van de Ven <arjanv@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
From: Frode Isaksen <fisaksen@bewan.com>
In-Reply-To: <20030429155842.A9215@devserv.devel.redhat.com>
Message-Id: <B693AA1B-7B08-11D7-8859-003065EF6010@bewan.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a more interesting/popular/widespread device than
> Lego Tower which uses these oneshots?
>
>
I have tested the patch with the Unicorn (ST70137) adsl usb chip and it 
is ok. Thanks...
Do you think it will be in the official 2.4.21 kernel ?

Frode


