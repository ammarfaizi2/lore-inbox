Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSE3LFj>; Thu, 30 May 2002 07:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSE3LFj>; Thu, 30 May 2002 07:05:39 -0400
Received: from c2ce9fba.adsl.oleane.fr ([194.206.159.186]:33907 "EHLO
	avalon.france.sdesigns.com") by vger.kernel.org with ESMTP
	id <S316582AbSE3LFh>; Thu, 30 May 2002 07:05:37 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Does pci_alloc_consisent really need to zero memory?
In-Reply-To: <200205300911.CAA01655@adam.yggdrasil.com>
	<20020530.024959.65186398.davem@redhat.com>
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 30 May 2002 13:05:26 +0200
Message-ID: <7w4rgpc2vd.fsf@avalon.france.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> I'd rather see a patch to DMA-mapping.txt that specifies the memory
> returned is zeroed out, as this is what every implementation appears
> to do.

What was the idea when writing the code that zeroes memory? It seems
so useless.

Sincerely yours,

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
