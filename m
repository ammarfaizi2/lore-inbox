Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTEEWCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEEWCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:02:39 -0400
Received: from pointblue.com.pl ([62.89.73.6]:31503 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261422AbTEEWCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:02:38 -0400
Subject: Re: [COMPILATION ERROR] 2.5.69 drivers/bluetooth/hci_usb.c
	USB_ZERO_PACKET
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506000246.A28427@electric-eye.fr.zoreil.com>
References: <1052170326.11699.2.camel@nalesnik>
	 <1052170720.11697.6.camel@nalesnik>
	 <20030506000246.A28427@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1052172546.11697.9.camel@nalesnik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 May 2003 23:09:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 23:02, Francois Romieu wrote:
> Grzegorz Jaskiewicz <gj@pointblue.com.pl> :
> [...]
> > If so, please give me some hints i will correct it my self :) 
> 
> If I remember M. KH's message of last week, it should be something like the
> following patch. Now I can't remember who he told it should be sent to :o)
> 
> Typo: s/USB_ZERO_PACKET/URB_ZERO_PACKET/
indeed. I can see it now somewhere on a list :-]

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

