Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293750AbSCAUsK>; Fri, 1 Mar 2002 15:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293747AbSCAUrv>; Fri, 1 Mar 2002 15:47:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61706 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293746AbSCAUrm>; Fri, 1 Mar 2002 15:47:42 -0500
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Fri, 1 Mar 2002 21:00:33 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), akpm@zip.com.au,
        aferber@techfak.uni-bielefeld.de, greearb@candelatech.com,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <3C7FD059.E88C026F@mandrakesoft.com> from "Jeff Garzik" at Mar 01, 2002 02:02:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gu8n-000515-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) IIRC Alan or somebody is trying to get rid of CONFIG_xxx_MODULE,
> because it doesn't really cover the case of when somebody builds VLAN
> "later on" as a module, but disables it initially.

News to me
