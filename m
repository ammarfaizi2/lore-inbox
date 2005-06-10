Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVFJW0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVFJW0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFJW0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:26:06 -0400
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:28122 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261286AbVFJWZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:25:58 -0400
Message-ID: <42AA133D.1050102@lifl.fr>
Date: Sat, 11 Jun 2005 00:25:01 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       mingo@elte.hu, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050608022646.GA3158@us.ibm.com> <42A73D15.6080201@nortel.com> <20050608192853.GE1295@us.ibm.com>
In-Reply-To: <20050608192853.GE1295@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've read the whole summary and really appreciated it. It's clear, 
precise and objective.

Just a small change to "1 - QoS":

> b.	For each service:
> 
> 	i.	Probability of missing a deadline due to software,
> 		ranging from 0 to 1, with the value of 1 corresponding
> 		to the hardest possible hard realtime.

I think it should be (by reference to how you define probability at the 
beginning of the section):
Probability of not missing any deadline due to software

Thanks again for writing this summary,
Eric
