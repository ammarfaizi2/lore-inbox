Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVLVN1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVLVN1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVLVN1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:27:47 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:52949 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965155AbVLVN1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:27:46 -0500
Message-ID: <43AABB89.2EADAB70@tv-sign.ru>
Date: Thu, 22 Dec 2005 17:43:21 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Daniel Walker <dwalker@mvista.com>, mingo@elte.hu, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02] RT: add back plist docs
References: <F989B1573A3A644BAB3920FBECA4D25A050C2B9B@orsmsx407>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Perez-Gonzalez, Inaky" wrote:
> 
> I don't have access to the real source now, but if the prio

You can look at it here:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=113509054523774

(the patch is against /dev/null).

Or get it along with user-space test:
	http://www.tv-sign.ru/oleg/plist.tgz

The only change is s/plist_next_entry/plist_first_entry/.

Oleg.
