Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272446AbTHNP77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272449AbTHNP76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:59:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:61630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272446AbTHNP76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:59:58 -0400
Date: Thu, 14 Aug 2003 08:56:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1 /proc/ikconfig/config adds space after numbers
Message-Id: <20030814085621.6cdbc90d.rddunlap@osdl.org>
In-Reply-To: <20030814135609.GA29328@middle.of.nowhere>
References: <20030814135609.GA29328@middle.of.nowhere>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 15:56:09 +0200 Jurriaan <thunder7@xs4all.nl> wrote:

| 2.6.0-test3-mm1:
| After every number in /proc/ikconfig/config there's an extra space.
| 
| This leads to messages like
| 
| .config:244: symbol value '1 ' invalid for
| SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
| 
| and lots more.

Yes, I've seen that and I have a patch for it somewhere.
I'll dig it up and post it.

Thanks,
--
~Randy
