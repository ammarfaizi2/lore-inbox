Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVK2LOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVK2LOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 06:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVK2LOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 06:14:09 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:52973 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751242AbVK2LOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 06:14:08 -0500
From: Duncan Sands <duncan.sands@free.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: speedtch driver, 2.6.14.2
Date: Tue, 29 Nov 2005 12:14:07 +0100
User-Agent: KMail/1.9
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk> <200511281234.45023.duncan.sands@free.fr> <m3sltgu1wn.fsf@defiant.localdomain>
In-Reply-To: <m3sltgu1wn.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511291214.08104.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, the firmware seems fine.

> 17:03:15 ATM dev 0: speedtch_check_status entered
> 17:03:17 usb 1-1: events/0 timed out on ep0in len=0/4
> 17:03:17 ATM dev 0: speedtch_read_status: MSG D failed
> 17:03:17 ATM dev 0: error -110 fetching device status

Is it always MSG D that fails?  Is failure of this message
correlated with anything else, eg: heavy network use?

Thanks,

Duncan.
