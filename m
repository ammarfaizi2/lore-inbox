Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131335AbRCWS4k>; Fri, 23 Mar 2001 13:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131336AbRCWS4a>; Fri, 23 Mar 2001 13:56:30 -0500
Received: from [195.63.194.11] ([195.63.194.11]:49935 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131335AbRCWS4Z>; Fri, 23 Mar 2001 13:56:25 -0500
Message-ID: <3ABB992F.D898885C@evision-ventures.com>
Date: Fri, 23 Mar 2001 19:42:55 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: SodaPop <soda@xirr.com>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.30.0103231053020.27155-100000@xirr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SodaPop wrote:
> 
> Rik, is there any way we could get a /proc entry for this, so that one
> could do something like:

I will respond; NO there is no way for security reasons this is not a
good idea.
 
> cat /proc/oom-kill-scores | sort +3
