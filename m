Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUITMd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUITMd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUITMd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:33:27 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:55807 "EHLO
	mwinf0801.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266366AbUITMd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:33:26 -0400
Subject: Re: OOM & [OT] util-linux-2.12e
From: Xavier Bestel <xavier.bestel@free.fr>
To: DervishD <lkml@dervishd.net>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20040920115942.GG5684@DervishD>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
	 <20040920110631.GJ5482@DervishD> <1095680326.27965.238.camel@gonzales>
	 <20040920115942.GG5684@DervishD>
Content-Type: text/plain; charset=utf-8
Message-Id: <1095683552.27965.240.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Sep 2004 14:32:32 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 20/09/2004 à 13:59, DervishD a écrit :
>     Hi Xavier :)
> 
>  * Xavier Bestel <xavier.bestel@free.fr> dixit:
> > > does the kernel *read* /proc/mounts contents?
> > /proc/mounts is kernel-generated on the fly (it's alive only during the
> > read() call).
> 
>     Then you can cripple it with any extra contents you want, am I
> wrong? The kernel won't mind...

Sure.

	Xav

