Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279376AbRJ2Swt>; Mon, 29 Oct 2001 13:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279372AbRJ2Swa>; Mon, 29 Oct 2001 13:52:30 -0500
Received: from freeside.toyota.com ([63.87.74.7]:6668 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S279370AbRJ2SwX>;
	Mon, 29 Oct 2001 13:52:23 -0500
Message-ID: <3BDDA583.96CBD8E2@lexus.com>
Date: Mon, 29 Oct 2001 10:52:51 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: eepro100.c & Intel integrated MBs
In-Reply-To: <11361.1004374395@nova.botz.org> <3BDD8EEC.6DFE6BA5@candelatech.com> <3BDD92E5.40EFFE90@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> No we do not.  eepro100 is the default in Red Hat Linux 7.1 and 7.2 at
> least.

hmm that's odd - when I did a clean install
of 7. 1 on my new system with intel mobo,
I discovered that modules.conf contained
the line "alias eth0 e100"

cu

jjs




