Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTLLWRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTLLWRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:17:37 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44444 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261967AbTLLWRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:17:33 -0500
Date: Fri, 12 Dec 2003 14:17:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ken <ken@nova.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4][PATCH] Xeon HT - SMT+SMP interrupt balancing
Message-ID: <59800000.1071267444@flay>
In-Reply-To: <3FDA1B5B.8090506@nova.org>
References: <3FD89EF5.30101@nova.org> <1316550000.1071163004@[10.10.2.4]> <3FDA1B5B.8090506@nova.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Nitin's patch is in 2.6 - does that work OK for you?
>> 
> 
> 	Thanks, Martin -- I wish I could test it.  As of -test11, the Adaptec/DPT I2O driver still doesn't build and I need that on this box.   I think I understand the error messages, but fixing them is beyond me.   It's obviously a known issue, so I don't think I can provide any new info on it.
> 
> 	Too bad for me -- I'm really looking forward to trying it and stuff like the NAPI for the e1000!

The code has been in for ages - so you should be able to use test9 
or test10 just fine, if that works better from a driver point of view.

M.

