Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318212AbSHIJgF>; Fri, 9 Aug 2002 05:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318214AbSHIJgF>; Fri, 9 Aug 2002 05:36:05 -0400
Received: from ulima.unil.ch ([130.223.144.143]:54402 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S318212AbSHIJgE>;
	Fri, 9 Aug 2002 05:36:04 -0400
Date: Fri, 9 Aug 2002 11:39:47 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no DMA on 2.4.20-pre1 on ICH4 (2.4.19-rc*-ac* did)
Message-ID: <20020809093947.GD23783@ulima.unil.ch>
References: <20020809090523.GB23783@ulima.unil.ch> <1028889530.30103.192.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1028889530.30103.192.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 11:38:50AM +0100, Alan Cox wrote:

> Maybe pre3/pre4. pre2 will have some other stuff that is also important
> and affects the IDE merge. The IDE stuff has a couple of bits I want to
> pin down as well.
> 
> For most cases if I push Marcelo the pci interface changes that ought to
> fix things.

Great, and in the meantime, the 2.4.19-*-ac* works just great
(2.4.20-pre1-ac1 didn't compil, and I don't see the bug report on the ml
I think I have sent: I should have done a bad manipulation to that
email...).

Thank you very much and have a great day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
