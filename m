Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262999AbREaC4V>; Wed, 30 May 2001 22:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263001AbREaC4L>; Wed, 30 May 2001 22:56:11 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63116 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262999AbREaCz4>;
	Wed, 30 May 2001 22:55:56 -0400
Message-ID: <3B15B2BA.D5A1EE88@mandrakesoft.com>
Date: Wed, 30 May 2001 22:55:54 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>,
        "'Martin Mares'" <pci-ids@ucw.cz>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.x: update for PCI vendor id 0x12d4
In-Reply-To: <14652.991276599@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com> wrote:
> >What I don't understand is why pci_ids.h doesn't get
> >generated from pci.ids as well.

Although they are similar, you cannot reliably generate useable C
constants from english words in the PCI id list...

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
