Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266660AbSKGWyE>; Thu, 7 Nov 2002 17:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266661AbSKGWyE>; Thu, 7 Nov 2002 17:54:04 -0500
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:57772 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id <S266660AbSKGWyC>;
	Thu, 7 Nov 2002 17:54:02 -0500
Date: Fri, 8 Nov 2002 00:00:20 +0100
From: Frank v Waveren <fvw@var.cx>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: /prod/PID-related proc fs question
Message-ID: <1036709784LKP.fvw@jareth.var.cx>
References: <Pine.LNX.4.33L2.0211061505250.5858-100000@rtlab.med.cornell.edu> <Pine.LNX.4.33L2.0211061509390.5858-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211061509390.5858-100000@rtlab.med.cornell.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about just modifiying argv? or forking? or using diskspace/statfs?
Basicly, you can't stop covert communication between processes unless
you use a _very_ heavily patched kernel, and this was never a design
goal.

-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|dse.nl|chello.nl] ICQ#10074100     1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
