Return-Path: <linux-kernel-owner+w=401wt.eu-S965128AbXAJVxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbXAJVxS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbXAJVxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:53:17 -0500
Received: from mail.tmr.com ([64.65.253.246]:40517 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965128AbXAJVxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:53:17 -0500
Message-ID: <45A5609C.1000308@tmr.com>
Date: Wed, 10 Jan 2007 16:54:36 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Alexy Khrabrov <deliverable@gmail.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: installing only the newly (re)built modules
References: <7c737f300701082029i1ce9f7d8oc67cb3339c9c2856@mail.gmail.com>
In-Reply-To: <7c737f300701082029i1ce9f7d8oc67cb3339c9c2856@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexy Khrabrov wrote:
> The 2.6 build system compiles only those modules whose config
> changed.  However, the install still installs all modules.
> 
> Is there a way to entice make modules_install to install only those
> new modules we've actually just changed/built?

Out of curiosity, why? I've noticed this, but the copy runs so fast I 
never really thought about it as an issue.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
