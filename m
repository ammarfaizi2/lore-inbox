Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283309AbRK2QYk>; Thu, 29 Nov 2001 11:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283310AbRK2QYa>; Thu, 29 Nov 2001 11:24:30 -0500
Received: from asbestos.brocade.com ([63.121.140.244]:11683 "EHLO
	mail.brocade.com") by vger.kernel.org with ESMTP id <S283309AbRK2QYW>;
	Thu, 29 Nov 2001 11:24:22 -0500
Date: Thu, 29 Nov 2001 08:24:10 -0800 (PST)
From: Grant Erickson <gerickso@brocade.com>
X-X-Sender: <gerickso@marathon>
Reply-To: Grant Erickson <gerickson@brocade.com>
To: Daniel Stodden <stodden@in.tum.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: where the hell is pci_read_config_xyz defined
In-Reply-To: <1007050377.32308.0.camel@atbode65>
Message-ID: <Pine.GSO.4.33.0111290822280.20995-100000@marathon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 2001, Daniel Stodden wrote:
> i hope this question is not too stupid, but i think i've grepped all
> through it now.
>
> i see the prototype in linux/pci.h
> i looked at i386/kernel/pci-pc.c.
> i see the bios/direct access diversion. i don't see (*pci_config_read)()
> referenced elsewhere except within the acpi stuff.
> i looked at drivers/pci/*
> i even consulted lxr. nyet. nada.
>
> giving up now. any hint would be greatly appreciated. am i blind?




>
> thanx,
> dns
>
>
>

-- 
Grant Erickson                            Phone:  (408) 487-8087
Brocade Communications Systems, Inc.      Fax:    (408) 392-1702
1745 Technology Drive
San Jose, CA 95110                        E-mail: gerickson@brocade.com

