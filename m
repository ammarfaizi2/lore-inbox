Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTEESEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTEESEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:04:22 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:46995 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261179AbTEESET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:04:19 -0400
Message-ID: <3EB6AA7C.8070501@nortelnetworks.com>
Date: Mon, 05 May 2003 14:16:28 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters.
References: <1052140733.2163.93.camel@spc9.esa.lanl.gov> <m1d6ixb8m7.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> The interesting thing becomes how do you measure system uptime.

In telecom at least, as long as the service which you are providing is 
available, you're "up".  The assumption is that you're "always" up, with brief 
(hopefully) interruptions for faults or upgrades.

Because of this, it may turn out that measuring service downtime is more 
meaningful than system uptime.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

