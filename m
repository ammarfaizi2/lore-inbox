Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUH0Odb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUH0Odb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUH0Oda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:33:30 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:18147
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S265462AbUH0Od3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:33:29 -0400
Message-ID: <412F4637.8080901@bio.ifi.lmu.de>
Date: Fri, 27 Aug 2004 16:33:27 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karl.vogel@seagha.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1+patches: Still a memory leak with cdrecord
References: <412F27C1.6030100@bio.ifi.lmu.de> <Xns9552A4ACE4078gmovkeb@80.91.224.252>
In-Reply-To: <Xns9552A4ACE4078gmovkeb@80.91.224.252>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karl Vogel wrote:
>
> I'm not sure, but this sounds a bit similar to a problem I am seeing. Are 
> you by any chance using the CFQ scheduler?! (elevator=cfq) If so, give 
> elevator=as or elevator=deadline a go.

I've no idea what the CFQ scheduler is :-) I'm not using anything like that
on the kernel append line, so if it's not standard, then no, I'm likely
not using it...

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

