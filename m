Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSFERqr>; Wed, 5 Jun 2002 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSFERqq>; Wed, 5 Jun 2002 13:46:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:34800 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315717AbSFERqp>; Wed, 5 Jun 2002 13:46:45 -0400
Subject: Re: promise PDC20267 onboard supermicro P3TDDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Thompson <wt@electro-mechanical.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020605132018.A4803@coredump.electro-mechanical.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 19:39:16 +0100
Message-Id: <1023302356.2443.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 18:20, William Thompson wrote:
> Removing the hdd from the controller and it boots just fine.  I tried a
> Quantum fireball lct10 05 and a seagate st34311a with the same results.
> 
> The bios on the pdc controller is v1.31

When 2.4.19pre10-ac2 appears please try that. I've merged a couple of
small fixes from Promise (not all the ones they want sorting - some of
it is a bit hairy so I'll let Andre do that 8))

Alan

