Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263364AbTDCNmK>; Thu, 3 Apr 2003 08:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbTDCNmK>; Thu, 3 Apr 2003 08:42:10 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:39440 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id <S263364AbTDCNmJ>;
	Thu, 3 Apr 2003 08:42:09 -0500
Message-ID: <3E8C3CD6.2060605@kn.vutbr.cz>
Date: Thu, 03 Apr 2003 15:53:26 +0200
From: Michal Schmidt <schmidt@kn.vutbr.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: cs, en
MIME-Version: 1.0
To: akpm@digeo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm3
References: <20030403090023$3168@gated-at.bofh.it>
In-Reply-To: <20030403090023$3168@gated-at.bofh.it>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> . The CPU scheduler starvation fix which was supposed to be in 2.5.66-mm2
>   actually wasn't included.  This time it's here for real.
> 

The starvation problem I used to hit with bzip2ing large files is indeed 
gone.

Michal.

