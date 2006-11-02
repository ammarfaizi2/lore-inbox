Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWKBD2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWKBD2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbWKBD2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:28:47 -0500
Received: from zrtps0kp.nortel.com ([47.140.192.56]:48832 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1750837AbWKBD2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:28:46 -0500
Message-ID: <454965E5.7090005@nortel.com>
Date: Wed, 01 Nov 2006 21:28:37 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> <20061101173356.GA18182@in.ibm.com> <45490F0D.7000804@nortel.com> <6599ad830611011548h4c0273c0xc5a653ea8726a692@mail.gmail.com>
In-Reply-To: <6599ad830611011548h4c0273c0xc5a653ea8726a692@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 03:28:41.0571 (UTC) FILETIME=[FE571B30:01C6FE2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:

> The framework should be flexible enough to let controllers register
> any control parameters (via the filesystem?) that they need, but it
> shouldn't contain explicit concepts like guarantees and limits.

If the framework was able to handle arbitrary control parameters, that 
would certainly be interesting.

Presumably there would be some way for the controllers to be called from 
the framework to validate those parameters?

Chris
