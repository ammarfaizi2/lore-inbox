Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbRAPQlU>; Tue, 16 Jan 2001 11:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132114AbRAPQlL>; Tue, 16 Jan 2001 11:41:11 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:60168 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S132109AbRAPQlA>; Tue, 16 Jan 2001 11:41:00 -0500
Date: Tue, 16 Jan 2001 17:40:56 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010116174056.A6067@burns.e-technik.uni-dortmund.de>
Mail-Followup-To: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1>; from Venkateshr@ami.com on Tue, Jan 16, 2001 at 10:49:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Venkatesh Ramamurthy wrote:

> we need some kind of signature being written in the drive, which the kernel
> will use for determining the boot drive and later re-order drives, if
> required.
> 
> Is someone handling this already? 

"mount by uuid"?

Amiga's Rigid Disk Block?

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
