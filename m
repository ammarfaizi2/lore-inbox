Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbRENUZC>; Mon, 14 May 2001 16:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbRENUYw>; Mon, 14 May 2001 16:24:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38593 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262480AbRENUYi>;
	Mon, 14 May 2001 16:24:38 -0400
Message-ID: <3B003EFC.61D9C16A@mandrakesoft.com>
Date: Mon, 14 May 2001 16:24:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zOfH-0001LG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note also that persistence of permissions and hardcoded in-kernel naming
is a problem throughout proc...  It's not unique to in-driver
filesystems.
-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
