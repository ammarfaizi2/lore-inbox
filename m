Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290485AbSAQWJe>; Thu, 17 Jan 2002 17:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290481AbSAQWJY>; Thu, 17 Jan 2002 17:09:24 -0500
Received: from [65.114.209.169] ([65.114.209.169]:56588 "EHLO mail3.cdsw.com")
	by vger.kernel.org with ESMTP id <S290485AbSAQWJM>;
	Thu, 17 Jan 2002 17:09:12 -0500
Message-ID: <3C474B9C.560DF747@excelco.com>
Date: Thu, 17 Jan 2002 15:09:32 -0700
From: root <howard@excelco.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-64GB-SMP i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: newbie with a qlogic host bus adapter
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Qlogic qla2200f host bus adapter for an optical SAN.  I am
running SuSE linux 7.1, I just downloaded kernel 2.4.17 sources and want
to compile a kernel.  But when I "make menuconfig" 
I go into scsi support, and into scs low level drivers, the qlogic
"qla2x00 QLC driver support" is not an option as it should be according
to the documentation for the qla2200.
how do i fix that?

also i tried to just compile the drivers to be modules, but i get the
error: /usr/src/linux-2.4/include/linux/modversions.h: No such file or
directory

where can I get this file?

Thankyou much.
Howard
