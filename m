Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163707AbWLGXAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163707AbWLGXAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163705AbWLGXAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:00:08 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:39843 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163700AbWLGW77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:59:59 -0500
Message-ID: <45789D0F.6060100@oracle.com>
Date: Thu, 07 Dec 2006 15:00:31 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
References: <20061207004838.4d84842c.randy.dunlap@oracle.com> <200612072254.51348.s0348365@sms.ed.ac.uk>
In-Reply-To: <200612072254.51348.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>> +but no space after unary operators:
>> +		sizeof  ++  --  &  *  +  -  ~  !  defined
> 
> You could mention typeof too, which is a keyword but should be done like 
> sizeof.

Hm, is that a gcc-ism?  It's not listed in the C99 spec.

Are there other gcc-isms that I should add?

Thanks.
-- 
~Randy
