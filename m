Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTLCRwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTLCRwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:52:18 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:9125 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265085AbTLCRwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:52:15 -0500
Message-ID: <3FCE22C0.6070202@colorfullife.com>
Date: Wed, 03 Dec 2003 18:52:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: vatsa@in.ibm.com, Raj <raju@mailandnews.com>, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com> <20031203182319.D14999@in.ibm.com> <3FCE217E.1080007@colorfullife.com>
In-Reply-To: <3FCE217E.1080007@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> No, a break would be wrong.

You are right, the break is correct. tid is thread id, not thread group id.

Sorry for the noise.
--
    Manfred

