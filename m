Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSGNAcU>; Sat, 13 Jul 2002 20:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSGNAcS>; Sat, 13 Jul 2002 20:32:18 -0400
Received: from codepoet.org ([166.70.99.138]:51169 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315483AbSGNAcN>;
	Sat, 13 Jul 2002 20:32:13 -0400
Date: Sat, 13 Jul 2002 18:35:06 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Anssi Saari <as@sci.fi>, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714003506.GD29007@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Anssi Saari <as@sci.fi>, linux-kernel@vger.kernel.org
References: <200207121955.g6CJtQur018433@burner.fokus.gmd.de> <20020713054058.GA19292@codepoet.org> <20020713105217.GB11996@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020713105217.GB11996@sci.fi>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jul 13, 2002 at 01:52:17PM +0300, Anssi Saari wrote:
> On Fri, Jul 12, 2002 at 11:40:58PM -0600, Erik Andersen wrote:
> > Yes, I have read the cdrecord source.  As you may recall from the
> > bug reports I would send periodically, I maintained the Debian
> > cdrecord/cdrtools package from 1998 till late last year...
> 
> > Ever look at the CDROM_SEND_PACKET ioctl?
> 
> Support for that appeared in cdrecord some time ago. From what little I've
> used it, it seems to work fine even though Joerg calls it pre-alpha code.

Cool.  I've not read over anything newer then cdrtools-1.10.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
