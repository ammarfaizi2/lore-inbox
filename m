Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTCBXAE>; Sun, 2 Mar 2003 18:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTCBXAD>; Sun, 2 Mar 2003 18:00:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63129
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261934AbTCBXAD>; Sun, 2 Mar 2003 18:00:03 -0500
Subject: Re: SCSI emulation causes kernel panic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: scott-kernel@thomasons.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303021601.24433.scott-kernel@thomasons.org>
References: <200303021601.24433.scott-kernel@thomasons.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046650451.4204.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 00:14:12 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 22:01, scott thomason wrote:
> 2.5.63, I still received the panic documented below, until I 
> turned on all the options under "Kernel Hacking". Then SCSI 
> emulation seems to work fine!

That might actually be useful info. What affect does the slab
poisoning option have in paticular.

