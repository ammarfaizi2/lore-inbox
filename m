Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287979AbSABU7y>; Wed, 2 Jan 2002 15:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287978AbSABU7t>; Wed, 2 Jan 2002 15:59:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47373 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287979AbSABU7a>; Wed, 2 Jan 2002 15:59:30 -0500
Subject: Re: system.map
To: timothy.covell@ashavan.org
Date: Wed, 2 Jan 2002 21:10:01 +0000 (GMT)
Cc: tmh@nothing-on.tv (Tony Hoyle), adriankok2000@yahoo.com.hk (adrian kok),
        linux-kernel@vger.kernel.org
In-Reply-To: <200201022049.g02KndSr022117@svr3.applink.net> from "Timothy Covell" at Jan 02, 2002 02:45:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Lse9-0005W9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, I guess that RedHat 7.2 must be an insane distribution:
> 
> make install
> + exec /sbin/installkernel 2.4.17 bzImage 
> /home/kernel/linux-2.4.17/System.map ''
> /etc/lilo.conf: No such file or directory
> make[1]: *** [install] Error 1

Thats a bug. Please report it to https://bugzilla.redhat.com/bugzilla if its
not already there
