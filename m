Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUE1Cz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUE1Cz6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 22:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUE1Cz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 22:55:58 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:1420 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262085AbUE1Cz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 22:55:57 -0400
Date: Fri, 28 May 2004 11:55:37 +0900 (JST)
Message-Id: <20040528.115537.719900493.nomura@linux.bs1.fc.nec.co.jp>
To: marcelo.tosatti@cyclades.com
Cc: j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org, andrea@suse.de,
       akpm@osdl.org, hugh@veritas.com
Subject: Re: [2.4] heavy-load under swap space shortage
From: j-nomura@ce.jp.nec.com
In-Reply-To: <20040526124104.GF6439@logos.cnet>
References: <Pine.LNX.4.44.0402051834070.1396-100000@localhost.localdomain>
	<20040310.195707.521627048.nomura@linux.bs1.fc.nec.co.jp>
	<20040526124104.GF6439@logos.cnet>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

> I think we can merge this patch.
> 
> Its very safe - default behaviour unchanged. 

Yes.

> Jun, are you willing to do another test for us if this gets merged
> in v2.4.27-pre4 ?

Yes. I'll try.

