Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTCEMCB>; Wed, 5 Mar 2003 07:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTCEMCB>; Wed, 5 Mar 2003 07:02:01 -0500
Received: from sysdoor.net ([62.212.103.239]:15116 "EHLO celia")
	by vger.kernel.org with ESMTP id <S265543AbTCEMCA>;
	Wed, 5 Mar 2003 07:02:00 -0500
Date: Wed, 5 Mar 2003 13:11:16 +0100
From: Michael Vergoz <mvergoz@sysdoor.com>
To: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High Mem Options
Message-Id: <20030305131116.0556f3a5.mvergoz@sysdoor.com>
In-Reply-To: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Every system can NOT manage more than 4GB memory on x86 processor (32 bits processor).
Because the system addressing is limited to 32Bits, well memory > 4GB is used generaly for memory spare...

Best regards,
Michael

On Wed, 05 Mar 2003 06:28:36 -0500
"Reed, Timothy A" <timothy.a.reed@lmco.com> wrote:

> Hello all,
> 	Yet another quick question...is there any down side to using the
> 64GB option over the 4GB option if the machine only has 2GB of RAM onboard??
> I would think this would be a performance issue?  Does the kernel only use
> the translation table if it has to access any memory location over 4GB?
> 
> TIA
> Tim Reed
> Email: timothy.a.reed@lmco.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
