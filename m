Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVFIHQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVFIHQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 03:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVFIHQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 03:16:54 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:53780 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S262312AbVFIHQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 03:16:50 -0400
Message-ID: <42A7ED17.5010707@sw.ru>
Date: Thu, 09 Jun 2005 11:17:43 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, pazke@donpac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
References: <20050607042931.23f8f8e0.akpm@osdl.org><42A6FF41.5040109@shadowen.org><20050608130117.341fa4ff.akpm@osdl.org><1051200000.1118272473@flay> <20050608162247.2c8f00f0.akpm@osdl.org> <1055500000.1118273677@flay>
In-Reply-To: <1055500000.1118273677@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --On Wednesday, June 08, 2005 16:22:47 -0700 Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>
>>>alt+sysrq+p does wierd stuff (is that new patch in your tree Andrew?
>>> doesn't seem to inter-react with the other NMI code well)
>>
>>What patch?
> 
> 
> Sorry.
> 
> nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch
> 
> It does seem to work. But probably needs some cleanup for the NMI
> errors.
If you give me to know where the problem come from I can fix it and make 
a cleanup.

Kirill

