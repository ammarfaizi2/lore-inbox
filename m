Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135810AbREANBJ>; Tue, 1 May 2001 09:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135801AbREANA7>; Tue, 1 May 2001 09:00:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42760 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135339AbREANAz>; Tue, 1 May 2001 09:00:55 -0400
Subject: Re: linux-2.4.4aa1 and 2.4.4aa2
To: ghsong@kjist.ac.kr (G. Hugh Song)
Date: Tue, 1 May 2001 14:04:12 +0100 (BST)
Cc: andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
In-Reply-To: <3AEEA6C9.F5D0FA51@kjist.ac.kr> from "G. Hugh Song" at May 01, 2001 09:06:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uZp8-0001bn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, the -pre versions are officially maintained by Linus, 
> while the -ac versions are maintained by Alan.  What is special
> in the -ac versions?    I see them trying to converge.  But 
> I'd like to know exactly what is actually being tried in the 
> -ac versions.

Your best guide is the change lists I post and the diff itself. In terms
of the problem you report I can't see any networking changes that could
be relevant between vanilla and -ac.

