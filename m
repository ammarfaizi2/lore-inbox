Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266676AbSLDPDU>; Wed, 4 Dec 2002 10:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266678AbSLDPDU>; Wed, 4 Dec 2002 10:03:20 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:53718 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S266676AbSLDPDT>; Wed, 4 Dec 2002 10:03:19 -0500
Subject: Re: Ctrl-Alt-Backspace kills machine not X. ACPI?
From: Alex Bennee <alex@braddahead.com>
To: Michael.Abshoff@mathematik.uni-dortmund.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DEE1596.1060803@mathematik.uni-dortmund.de>
References: <1039005946.2366.25.camel@cambridge.braddahead> 
	<3DEE1596.1060803@mathematik.uni-dortmund.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 04 Dec 2002 15:08:01 +0000
Message-Id: <1039014482.1862.7.camel@cambridge.braddahead>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 14:47, Michael Abshoff wrote:
> do you use an SIS-Board by any chance. The is a Bios-Option that powers 
> down
> the system. Disabeling it had no affect on my mashine, but there may be 
> a Bios
> update available.

I updated the BIOS to the latest (non-Beta) flash provided by
Fujitsu/Siemens but the BIOS offers no way to dsiable power-save stuff,
just the type of suspend it does (S1 or S3).
 
> I was also told that resetting the Bios via jumper might help.

Funnily enough Gigabyte no longer carry the motherboard manual for the
GA-8STXCFS, only some of the other variants. Maybe I should take the
radical step and put LinuxBIOS on it but seeing as this is my works PC
maybe I should save that for a day when I don't have deadlines :-)

-- 
Alex Bennee
Senior Hacker, Braddahead Ltd
The above is probably my personal opinion and may not be that of my
employer

