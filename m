Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbTBFPWs>; Thu, 6 Feb 2003 10:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbTBFPWs>; Thu, 6 Feb 2003 10:22:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58270
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267328AbTBFPWr>; Thu, 6 Feb 2003 10:22:47 -0500
Subject: Re: [PATCH] 2.4.20 still can't detect my SCSI disk
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1470960000.1044432921@aslan.scsiguy.com>
References: <200302050738.h157c5s16708@Port.imtp.ilyichevsk.odessa.ua>
	 <1470960000.1044432921@aslan.scsiguy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044548899.10374.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Feb 2003 16:28:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 08:15, Justin T. Gibbs wrote:
> I've tried to get Marcello to update the aic7xxx driver in the 2.4.X
> tree to no avail.  The Olvetti support was added to my version of
> the aic7xxx driver some time ago.  You can get my latest driver
> versions from here:
> 
> http://people.FreeBSD.org/~gibbs/linux/SRC/

The files here prohibit redistribution in part. I assume this is an oversight ?

(c) 2002 Adaptec, Inc. All Rights Reserved. No part of this
publication may be reproduced, stored in a retrieval system, or
transmitted in any form or by any means, electronic, mechanical,
photocopying, recording or otherwise, without prior written consent
of Adaptec, Inc., 691 South Milpitas Blvd., Milpitas, CA 95035.

I've merged the rest into the -ac tree however.

