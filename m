Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbRDQMSF>; Tue, 17 Apr 2001 08:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDQMRp>; Tue, 17 Apr 2001 08:17:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22798 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132513AbRDQMRe>; Tue, 17 Apr 2001 08:17:34 -0400
Subject: Re: Still cannot compile
To: ankry@green.mif.pg.gda.pl
Date: Tue, 17 Apr 2001 13:19:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), eccesys@topmail.de (mirabilos),
        linux-kernel@vger.kernel.org
In-Reply-To: <200104171014.MAA24852@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Apr 17, 2001 12:14:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pURl-0002Et-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Alan Cox wrote:"
> > > But we _do need_ a working current-kernel.
> > 
> > Use gcc 2.95/2.96
> 
> Is 2.91.66 already obsolete ?
> Documentation/Changes does not suggest this ...

Its 'temporarily not working'. The rwsem stuff needs cleaning up or ifdeffing
a bit to handle egcs thats all
