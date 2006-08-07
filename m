Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWHGIJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWHGIJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWHGIJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:09:09 -0400
Received: from lx-ltd.ru ([85.113.143.174]:27841 "EHLO iserver.lx.intercon.ru")
	by vger.kernel.org with ESMTP id S1751151AbWHGIJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:09:08 -0400
X-Comment-To: Greg KH
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OHCI and SKIP bit
References: <m3irlbibsp.fsf@lx-ltd.ru> <20060805063540.GA25389@kroah.com>
From: Sergej Pupykin <ps@lx-ltd.ru>
Date: 07 Aug 2006 12:09:06 +0400
In-Reply-To: <20060805063540.GA25389@kroah.com>
Message-ID: <m3psfdynkt.fsf@lx-ltd.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 GK> The OHCI USB or IEEE1394 spec?

OHCI USB

 GK> Why not ask this on the specific subsystem developer mailing list?  Is
 GK> this not working properly for you on your hardware?

We are checking it now. It seems we'll have a patch soon...
(sometime ohci lose write urb callback at least on 2.4.32 kernel)

