Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289108AbSANWhe>; Mon, 14 Jan 2002 17:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289120AbSANWh1>; Mon, 14 Jan 2002 17:37:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42769 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289108AbSANWgY>;
	Mon, 14 Jan 2002 17:36:24 -0500
Message-ID: <3C435D65.E7FC999D@mandrakesoft.com>
Date: Mon, 14 Jan 2002 17:36:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the 
 elegant solution)
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com> <20020114213732.M15139@suse.de> <20020114153844.A20537@thyrsus.com> <3C4356A9.367BC989@mandrakesoft.com> <20020114231855.A21353@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Mon, Jan 14, 2002 at 05:07:37PM -0500, Jeff Garzik wrote:
>  >
>  > For network cards one needs only to issue the ETHTOOL_GDRVINFO ioctl to
>  > find out what hardware is associated with an ethernet interface.
> 
>  but not all the net drivers support this yet do they?

correct.  But it is the proper path one should take on this particular
train of thought ;-)

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
