Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272401AbRH3SnS>; Thu, 30 Aug 2001 14:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272402AbRH3SnI>; Thu, 30 Aug 2001 14:43:08 -0400
Received: from quark.didntduck.org ([216.43.55.190]:27653 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S272401AbRH3Smt>; Thu, 30 Aug 2001 14:42:49 -0400
Message-ID: <3B8E8914.B197BD77@didntduck.org>
Date: Thu, 30 Aug 2001 14:42:28 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>,
        linux-kernel@vger.kernel.org
Subject: Re: EISA irq probing problem (ESIC chip)
In-Reply-To: <E15cTqY-0001GF-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Out of curiosity, have you tried a recent -ac kernel with PnP BIOS
> > enabled?  EISA devices might possibly show up there.
> 
> I believe EISA bios services are different

You wouldn't happed to know where I could find docs on the EISA 32-bit
services would you?  I know they exist from seeing references in the PCI
bios specs, but a Google search didn't turn up anything.

--

				Brian Gerst
