Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSERMVC>; Sat, 18 May 2002 08:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSERMVB>; Sat, 18 May 2002 08:21:01 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:57334 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312480AbSERMVB>; Sat, 18 May 2002 08:21:01 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0205171113550.1002-100000@puppy.afrinc.com> 
To: dave@AFRInc.com
Cc: John Ruttenberg <rutt@chezrutt.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Dell Inspiron i8100 with 2 batteries 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 18 May 2002 13:20:37 +0100
Message-ID: <19261.1021724437@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dave@AFRInc.com said:
>  I've got the same laptop with one battery, but I'm using ACPI. None
> of the current user-space utilities parse this stuff particularly well
> (the filenames in /proc/acpi have changed), but the data all look
> reasonable. 

Those data also come straight from the BIOS. The ACPI code on those laptops 
is all just traps into the SMM BIOS. I'd guess it's running exactly the 
same code inside.

--
dwmw2


