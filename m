Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVE3Wj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVE3Wj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVE3Wj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:39:57 -0400
Received: from opersys.com ([64.40.108.71]:28431 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261799AbVE3Wjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:39:31 -0400
Message-ID: <429B9880.1070604@opersys.com>
Date: Mon, 30 May 2005 18:49:36 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Esben Nielsen <simlo@phys.au.dk>, Nick Piggin <nickpiggin@yahoo.com.au>,
       kus Kusche Klaus <kus@keba.com>, James Bruce <bruce@andrew.cmu.edu>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk> <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com>
In-Reply-To: <20050530223434.GC9972@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
>>From my memory DRM drivers have direct path to the vertical retrace
> through the current ioctl() interface. It's not an issue for that driver
> and probably many others that use simple syscalls like that.

This is rather short. Can you elaborate a little on what you're trying
to say here? thanks.

> The RT patch isn't hard to maintain and only one jerk-off objected to
> it without providing any useful information why the single kernel
> approach is faulty other than it jars his easily offended sensibilities

I didn't say the RT patch was hard to maintain. I said that it increased
the cost of maintenance for the rest of the kernel (which is the feeling
that seems to be echoed by other peoples' answers in this thread.)

BTW, please take a breath here. I'm not interested in taking part in a
flame-fest.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
