Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVGNGUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVGNGUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 02:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVGNGUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 02:20:11 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:43840 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262661AbVGNGUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 02:20:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PTikbOfZ1h4IURqi9rJCYPnpX+c91vxbDMjTJ+H8rBOZbzpNHuZKd9xIo/Agtpd1N77c7EkrwW++hWcPLHhuh9VmJmGx5UyEZ+SZJa9k07Uw6V2DdgaRd3P/Vvw9ypXsUYf7nu/6LsCBHkUMIxU2M06TDVMKM5D/UTfVZry1PyY=
Message-ID: <42D60417.9080407@gmail.com>
Date: Thu, 14 Jul 2005 02:20:07 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: realtime-preempt + reiser4?
References: <42D4201A.9050303@gmail.com>	 <1121198723.10580.10.camel@mindpipe>  <42D45438.6040409@gmail.com> <1121213099.3548.39.camel@localhost.localdomain> <42D53FF6.2020200@namesys.com>
In-Reply-To: <42D53FF6.2020200@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir V. Saveliev wrote:
> 
> ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.12/reiser4-for-2.6.12-realtime-preempt-2.6.12-final-V0.7.51-29.patch.gz 
> 
> It applies to 2.6.12 + 
> http://people.redhat.com/mingo/realtime-preempt/older/realtime-preempt-2.6.12-final-V0.7.51-29 

Ah, this is just what I was looking for. Should have thought to search 
namesys.com.
