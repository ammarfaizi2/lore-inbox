Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286988AbRL2BB5>; Fri, 28 Dec 2001 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284542AbRL2BBr>; Fri, 28 Dec 2001 20:01:47 -0500
Received: from ns.suse.de ([213.95.15.193]:6157 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287043AbRL2BBd>;
	Fri, 28 Dec 2001 20:01:33 -0500
Date: Sat, 29 Dec 2001 02:01:31 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj7 -- Compile errors in ieee1394/sbp2.c
In-Reply-To: <1009570306.1816.81.camel@stomata.megapathdsl.net>
Message-ID: <Pine.LNX.4.33.0112290148110.27193-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Dec 2001, Miles Lane wrote:

> sbp2.c:2948: `MODULE_SCSI_HA' undeclared (first use in this function)
> sbp2.c:2948: (Each undeclared identifier is reported only once
> sbp2.c:2948: for each function it appears in.)

Ok, this will require a little brain surgery, and may also need
some bio work for 2.5 to cope with the scsi changes.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

