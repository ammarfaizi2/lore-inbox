Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVEKGzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVEKGzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 02:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVEKGzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 02:55:10 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:32221 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261898AbVEKGzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 02:55:06 -0400
Message-ID: <4281AE09.A1ADE29E@tv-sign.ru>
Date: Wed, 11 May 2005 11:02:33 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dwalker@mvista.com
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] rt_mutex: add new plist implementation
References: <F989B1573A3A644BAB3920FBECA4D25A0338B637@orsmsx407> <1115754260.14326.26.camel@dhcp153.mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 
> I still say re-implementation of plist is a waste .. Why re-make the
> wheel when you have a perfectly good starting point .

Because it does not work? I think you have missed my first message on
this topic: http://marc.theaimsgroup.com/?l=linux-kernel&m=111536999732736

I had no intent to re-implement plists, it was you who told me:
>
> Make a patch .

Oleg.
