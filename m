Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUH0Pi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUH0Pi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266216AbUH0Piz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:38:55 -0400
Received: from atropo.wseurope.com ([195.110.122.67]:41180 "EHLO
	atropo.wseurope.com") by vger.kernel.org with ESMTP id S266188AbUH0Pgj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:36:39 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Gergely Tamas <dice@mfa.kfki.hu>
Subject: Re: data loss in 2.6.9-rc1-mm1
Date: Fri, 27 Aug 2004 17:36:34 +0200
User-Agent: KMail/1.7
Cc: Hugh Dickins <hugh@veritas.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, Ram Pai <linuxram@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <200408271455.03733.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0408271448041.4725-100000@localhost.localdomain> <20040827141828.GA19272@mfa.kfki.hu>
In-Reply-To: <20040827141828.GA19272@mfa.kfki.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408271736.34672.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 16:18, venerdì 27 agosto 2004, Gergely Tamas ha scritto:
>  > Hmm, 2.6.9-rc1-mm1 looks like not a release to trust your (page
>  > size multiple) data to!  You should find the patch below fixes it
>  > (and, I hope, the issue the erroneous patches were trying to fix).
>  >
>  > Signed-off-by: Hugh Dickins <hugh@veritas.com>


JFYI: It seems that this patch fixes my problem with rpm database as well; 
thanks a lot.


-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
