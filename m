Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313271AbSDDRlh>; Thu, 4 Apr 2002 12:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313280AbSDDRl2>; Thu, 4 Apr 2002 12:41:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32782 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313271AbSDDRlP>; Thu, 4 Apr 2002 12:41:15 -0500
Subject: Re: [2.4.18] /proc/stat does not show disk_io stats for all IDE d isks
To: hch@infradead.org ('Christoph Hellwig')
Date: Thu, 4 Apr 2002 18:57:04 +0100 (BST)
Cc: dana.lacoste@peregrine.com (Dana Lacoste),
        hch@infradead.org ('Christoph Hellwig'), agazo@unex.es (Alfonso Gazo),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020404174455.A28340@infradead.org> from "'Christoph Hellwig'" at Apr 04, 2002 05:44:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tBTs-0006RJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > SARD fixes this by tracking all the relevant disk info properly, but it's
> > not in the mainline kernel :(
> 
> I guess it will be in 2.4.19..

If the authors care to submit it usre...
