Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWCFRX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWCFRX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWCFRX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:23:29 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:59826 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1751408AbWCFRX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:23:29 -0500
Message-ID: <440C6FF9.80300@nortel.com>
Date: Mon, 06 Mar 2006 11:23:05 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Olivier Galibert <galibert@pobox.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Is that an acceptable interface change?
References: <20060306011757.GA21649@dspnet.fr.eu.org>	 <1141631568.4084.2.camel@laptopd505.fenrus.org>	 <20060306155021.GA23513@dspnet.fr.eu.org> <9a8748490603060755r55b3584bpf0a16451a57925b5@mail.gmail.com>
In-Reply-To: <9a8748490603060755r55b3584bpf0a16451a57925b5@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2006 17:23:07.0120 (UTC) FILETIME=[A22DDF00:01C64142]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> Userspace apps should not include kernel headers, period.
> So, userspace applications really shouldn't care.

Yeah, but doesn't changing the names like this just make more work for 
the guys that sanitize the kernel headers and have to stay 
source-compatible with previous versions?

I mean, we shouldn't make extra work for other projects just for fun...

Chris
