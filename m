Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135901AbRD3UmO>; Mon, 30 Apr 2001 16:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135900AbRD3UmF>; Mon, 30 Apr 2001 16:42:05 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27112 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135899AbRD3Uly>;
	Mon, 30 Apr 2001 16:41:54 -0400
Message-ID: <3AEDCE0C.3AB34D47@mandrakesoft.com>
Date: Mon, 30 Apr 2001 16:41:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-via@havoc.gtf.org
Cc: Capricelli Thomas <orzel@kde.org>, josh <skulcap@mammoth.org>,
        Arjan van de Ven <arjanv@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.4: Via audio fixes
In-Reply-To: <XFMail.010501044118.hosler@lugs.org.sg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be possible for you to make a code change and send me the dmesg
output?

Update linux/arch/i386/kernel/pci-i386.h and change
-#undef DEBUG
+#define DEBUG 1

Recompile, and privately e-mail me "dmesg -s 16384" output...

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
