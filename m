Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUHTM2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUHTM2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUHTM0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:26:22 -0400
Received: from the-village.bc.nu ([81.2.110.252]:34951 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266643AbUHTM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:26:02 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, kernel@wildsau.enemy.org,
       diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4125AC3B.8060707@bio.ifi.lmu.de>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <4125AC3B.8060707@bio.ifi.lmu.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093001024.30854.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 12:23:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 08:46, Frank Steiner wrote:
> The security thing and the problems with 2.6.8.1 keeping users from burning
> (I have my set patched in now to allow users burning again, nor sure if
> it is safe...) is a general issue as far as I understand, and nothing
> SuSE specific.

Its a generic "kernel < 2.6.8.1" thing. Its one reason Fedora pushed a
2.6.8- kernel. If you've re-enabled unlimited access to your box you've
let your users destroy your machine. Whether that matters probably
depends on your users.
