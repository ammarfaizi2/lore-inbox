Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTD3HSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 03:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTD3HSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 03:18:52 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:4302 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262110AbTD3HSw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 03:18:52 -0400
Date: Wed, 30 Apr 2003 09:31:05 +0200
Subject: Re: PATCH: usb-uhci: interrupt out with urb->interval 0  [linux-usb-devel]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Arjan Van de Ven <arjanv@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
From: Frode Isaksen <fisaksen@bewan.com>
In-Reply-To: <20030429155842.A9215@devserv.devel.redhat.com>
Message-Id: <B4041A51-7ADD-11D7-8859-003065EF6010@bewan.com>
Content-Transfer-Encoding: 8BIT
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le mardi, 29 avr 2003, à 21:58 Europe/Paris, Pete Zaitcev a écrit :

> Pretty obvious, but I'd rather see something like the attached
> patch instead. The original code was obviously a case of a rash
> copy-paste, complete with an unused "int i".

I will test your patch - my patch was the quickest way to fix the 
problem, but it was obviously not very elegant  !!!!

>
> Is there a more interesting/popular/widespread device than
> Lego Tower which uses these oneshots?

I am using it in an USB adsl adapter (unicorn - ST70137 chip from 
STMicro).

Hilsen,
Frode

>
> -- Pete

