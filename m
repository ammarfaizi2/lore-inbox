Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTLKHaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTLKHaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:30:16 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:40075 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264372AbTLKHaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:30:10 -0500
Message-ID: <3FD81CFE.30005@cyberone.com.au>
Date: Thu, 11 Dec 2003 18:30:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
References: <1071122742.5149.12.camel@idefix.homelinux.org> <1288980000.1071126438@[10.10.2.4]> <1071126929.5149.24.camel@idefix.homelinux.org>
In-Reply-To: <1071126929.5149.24.camel@idefix.homelinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jean-Marc Valin wrote:

>>Why would you want to *increase* HZ? I'd say 1000 is already too high
>>personally, but I'm curious what you'd want to do with it? Embedded
>>real-time stuff?
>>
>
>Actually, my reasons may sound a little strange, but basically I'd be
>fine with HZ=1000 if it wasn't for that annoying ~1 kHz sound when the
>CPU is idle (probably bad capacitors). By increasing HZ to 10 kHz, the
>sound is at a frequency where the ear is much less sensitive. Anyway, I
>thought some people might be interested in high HZ for other (more
>fundamental) reasons, so I posted the patch.
>

Heh! Does it scare your dog away? ;)

