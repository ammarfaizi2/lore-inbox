Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTHZLNH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 07:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTHZLNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 07:13:07 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:21890 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263572AbTHZLNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 07:13:06 -0400
Message-Id: <200308261112.h7QBCVNv020928@ginger.cmf.nrl.navy.mil>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
       Bartlomiej Solarz-Niesluchowski <solarz@wsisiz.edu.pl>
Subject: Re: [Linux-ATM-General] linux-2.4.22 Oops on ATM PCA-200EPC 
In-Reply-To: Message from Lukasz Trabinski <lukasz@wsisiz.edu.pl> 
   of "Tue, 26 Aug 2003 01:11:13 +0200." <Pine.LNX.4.53.0308260104580.17995@oceanic.wsisiz.edu.pl> 
Date: Tue, 26 Aug 2003 07:12:33 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have always used vanilla kernel with very old patch for ATM
>(name: linux-2.3.99-pre6-fore200e-0.2f.patch) It worked well -
>trouble-free. 
>I have just tried vanilla 2.4.22, here is oops. ATM doesn't work :(

what did you do to get this crash?  just startup an interface?
is clip built as a module?

