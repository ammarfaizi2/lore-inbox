Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135725AbRAYUXm>; Thu, 25 Jan 2001 15:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135805AbRAYUXc>; Thu, 25 Jan 2001 15:23:32 -0500
Received: from igor.phys.ntnu.no ([129.241.48.108]:11279 "EHLO
	igor.phys.ntnu.no") by vger.kernel.org with ESMTP
	id <S135725AbRAYUXS>; Thu, 25 Jan 2001 15:23:18 -0500
To: Ondrej Sury <ondrej@globe.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 slowdown at boot.
In-Reply-To: <87k87jzjlt.fsf@ondrej.office.globe.cz>
From: Terje Rosten <terjeros@phys.ntnu.no>
Date: 25 Jan 2001 21:23:11 +0100
In-Reply-To: <87k87jzjlt.fsf@ondrej.office.globe.cz>
Message-ID: <yojzogfs7o0.fsf@igor.phys.ntnu.no>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ondrej Sury
| 
| 2.4.1-pre10 slows down after printing those (maybe ACPI or reiserfs issue),
| and even SysRQ-(s,u,b) is not imediate and waits several (two+) seconds
| before (syncing,remounting,booting).

I'm also seeing this. I think it's ACPI related, I am not using
reiserfs. I have similar hardware.


 - terje
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
