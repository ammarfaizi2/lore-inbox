Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272246AbRH3PEn>; Thu, 30 Aug 2001 11:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272255AbRH3PEd>; Thu, 30 Aug 2001 11:04:33 -0400
Received: from quark.didntduck.org ([216.43.55.190]:9477 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S272256AbRH3PEW>; Thu, 30 Aug 2001 11:04:22 -0400
Message-ID: <3B8E55F3.EA83A325@didntduck.org>
Date: Thu, 30 Aug 2001 11:04:19 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: EISA irq probing problem (ESIC chip)
In-Reply-To: <3B8E35E3.51DBDC34@pandora.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Vandewoestyne wrote:
> 
> I am trying to write a linux driver for an EISA data aquisition card.
> More info on my little special project is at
> http://mc303.ulyssis.org/heim/
> 

Out of curiosity, have you tried a recent -ac kernel with PnP BIOS
enabled?  EISA devices might possibly show up there.

--

				Brian Gerst
