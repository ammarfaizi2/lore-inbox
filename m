Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUCQVao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbUCQVao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:30:44 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:59623 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262085AbUCQVam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:30:42 -0500
Message-ID: <4058C37F.8070409@nortelnetworks.com>
Date: Wed, 17 Mar 2004 16:30:39 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: status of PREEMPT and SMP together?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some of the Kconfig files (ppc/ppc64) seem to be of the opinion that 
there are races when both SMP and PREEMPT are enabled.

Is this still the case, or are they out of date?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

