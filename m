Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUHMQ2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUHMQ2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUHMQ2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:28:05 -0400
Received: from tristate.vision.ee ([194.204.30.144]:48320 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S266173AbUHMQ2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:28:02 -0400
Message-ID: <411CEC0F.9000707@vision.ee>
Date: Fri, 13 Aug 2004 19:27:59 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Latency profiling.
References: <411CE8DC.9010609@superbug.demon.co.uk>
In-Reply-To: <411CE8DC.9010609@superbug.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dou you have DMA enabled for your hard-disk?

# hdparm /dev/your_hard_disk will tell.

Lenar

James Courtier-Dutton wrote:

> I have a problem that my desktop linux system becomes un-responsive 
> when there is a lot of Hard Disc access. I.E. During HD access, the 
> mouse fails to move.



