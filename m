Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTLLTsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTLLTsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:48:15 -0500
Received: from main.aitcom.net ([208.234.1.35]:3819 "EHLO ait.com")
	by vger.kernel.org with ESMTP id S261879AbTLLTsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:48:12 -0500
Message-ID: <3FDA1B5B.8090506@nova.org>
Date: Fri, 12 Dec 2003 14:47:39 -0500
From: Ken <ken@nova.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4][PATCH] Xeon HT - SMT+SMP interrupt balancing
References: <3FD89EF5.30101@nova.org> <1316550000.1071163004@[10.10.2.4]>
In-Reply-To: <1316550000.1071163004@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> 
> Nitin's patch is in 2.6 - does that work OK for you?
> 

	Thanks, Martin -- I wish I could test it.  As of -test11, the 
Adaptec/DPT I2O driver still doesn't build and I need that on this box. 
  I think I understand the error messages, but fixing them is beyond me. 
  It's obviously a known issue, so I don't think I can provide any new 
info on it.

	Too bad for me -- I'm really looking forward to trying it and stuff 
like the NAPI for the e1000!

Regards,
Ken Beaty

