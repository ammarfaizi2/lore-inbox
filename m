Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTKNVer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbTKNVer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:34:47 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:3055 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264472AbTKNVeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:34:37 -0500
Message-ID: <3FB54A62.6020601@nortelnetworks.com>
Date: Fri, 14 Nov 2003 16:34:26 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why no Kconfig in "kernel" subdir?
References: <3FB50B4D.1000300@nortelnetworks.com> <20031114092319.5260bd01.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:


> I consider PREEMPT and SMP arch-specific, not generic.

Interesting.  Might I ask why?  I thought that most of PREEMPT was 
pretty arch-neutral.

> Will init/Kconfig do what you want?

As long as there is some place to put generic options that are 
applicable to the system as a whole, then I'm happy.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

