Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbTD1RmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTD1RmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:42:24 -0400
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:10192 "EHLO
	renegade") by vger.kernel.org with ESMTP id S261229AbTD1RmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:42:21 -0400
Date: Mon, 28 Apr 2003 10:54:23 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Subject: archives of bk commits mailing list
Message-ID: <20030428175423.GJ24397@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Does anyone have mboxes for the two bk commits (head and 24) mailing lists,
going back to the beginning? It would be great if you could make these
available somewhere. I asked David, but he doesn't have them. He explained
how to recreate them with BK, but I don't think I qualify for the free license.

David told me
> http://cvs.infradead.org/cgi-bin/cvsweb.cgi/bkexport/
> 
> Then with a current BK repository do something like
>
> for a in 'bk changes -rv2.5.68.. -D:I:\ ` do  
>         echo From nobody@nowhere
>         mailcset.sh $a
> done > mbox

Be well,
Zack

-- 
Zack Brown
