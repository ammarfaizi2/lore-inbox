Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290603AbSARFRZ>; Fri, 18 Jan 2002 00:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290604AbSARFRP>; Fri, 18 Jan 2002 00:17:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46349 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290603AbSARFRI>;
	Fri, 18 Jan 2002 00:17:08 -0500
Message-ID: <3C47AFC6.A61A3586@mandrakesoft.com>
Date: Fri, 18 Jan 2002 00:16:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Pozsar Balazs <pozsy@sch.bme.hu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 8139too: too early dev_kfree_skb
In-Reply-To: <Pine.GSO.4.30.0201092029570.14274-100000@balu> <20020109125411.R769@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Jan 09, 2002  20:35 +0100, Pozsar Balazs wrote:
> > This patch was originally sent to lkml on nov 30, 2001, from
> > <kumon@flab.fujitsu.co.jp>, but it is not in 2.4.18-pre2.
> >
> > Was it just overlooked, or is it unneccessary?
> 
> I seem to recall that it was solved differently.  Please read the whole
> thread.

And IIRC you were the one that solved it differently :)

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
