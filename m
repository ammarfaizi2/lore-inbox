Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266499AbUGKFDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUGKFDk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 01:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUGKFDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 01:03:40 -0400
Received: from opersys.com ([64.40.108.71]:27144 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S266499AbUGKFDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 01:03:39 -0400
Message-ID: <40F0C8E8.2060908@opersys.com>
Date: Sun, 11 Jul 2004 00:58:16 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Adam Kropelin <akropel1@rochester.rr.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tim.bird@am.sony.com,
       celinux-dev@tree.celinuxforum.org, tpoynor@mvista.com,
       geert@linux-m68k.org
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
References: <40EEF10F.1030404@am.sony.com> <20040710182527.47534358.akpm@osdl.org> <20040710234459.A26981@mail.kroptech.com> <200407102351.05059.dtor_core@ameritech.net>
In-Reply-To: <200407102351.05059.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dmitry Torokhov wrote:
> Do we need to encourage ordinary users to turn this option on? 99% of
> non-embedded market is much safer with that option off...

There are other boot params that gather similar if not higher percentages.
profile= is one of those.

Also, keep in mind that in a not too distant future (and indeed today for
some folks already) recompiling and fine-tuning the Linux kernel for your
latest gizmo will not be as foreign as your statement may make it sound.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

