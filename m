Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264250AbUDOPC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUDOPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:02:57 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:65170 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264250AbUDOPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:02:56 -0400
Message-ID: <407EA2E5.7080504@nortelnetworks.com>
Date: Thu, 15 Apr 2004 10:57:41 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modules in 2.6 kernel - question for FAQ?
References: <200404142142.41137.arekm@pld-linux.org>	 <1081993968.17782.112.camel@bach> <20040415044452.GA2215@mars.ravnborg.org>	 <1082004860.17780.143.camel@bach>  <407E9127.8070303@nortelnetworks.com> <1082037381.12255.1.camel@laptop.fenrus.com>
In-Reply-To: <1082037381.12255.1.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> I think you misunderstood; even binary only module build stuff needs to
> use the kernel makefiles, via make -C /path/to/kernel etc, as documented
> in Documentation/kbuild/modules.txt

I know this, you know this.  There are hardware vendors that still do 
not know this--or at least aren't doing it.

Chris
