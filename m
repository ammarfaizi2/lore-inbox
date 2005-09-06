Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVIFCiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVIFCiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 22:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVIFCiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 22:38:17 -0400
Received: from gate.ebshome.net ([64.81.67.12]:19891 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S1751301AbVIFCiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 22:38:16 -0400
Date: Mon, 5 Sep 2005 19:38:16 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
Message-ID: <20050906023816.GB5512@gate.ebshome.net>
Mail-Followup-To: viro@ZenIV.linux.org.uk,
	Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20050906004423.GO5155@ZenIV.linux.org.uk> <20050906021535.GA5512@gate.ebshome.net> <20050906022733.GU5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906022733.GU5155@ZenIV.linux.org.uk>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 03:27:33AM +0100, viro@ZenIV.linux.org.uk wrote:
> On Mon, Sep 05, 2005 at 07:15:35PM -0700, Eugene Surovegin wrote:
>  
> > Identical fix is already in -mm
> 
> Then it really should go upstream; obvious fixes like that are not
> something that needs filtration...

Well, it's not up to me, really - I just follow our usual patch 
submit procedure (i.e. send everything to Andrew). However, patch was 
sent today in the morning (PDT), so I think Andrew will forward it to 
Linus soon.

-- 
Eugene

