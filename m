Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbUDKJ5s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 05:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUDKJ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 05:57:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63174 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262309AbUDKJ5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 05:57:48 -0400
Message-Id: <200404110957.i3B9vgF21362@owlet.beaverton.ibm.com>
To: shai@ftcon.com
cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Darren Hart'" <dvhltc@us.ibm.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>, ak@suse.de,
       "'Martin J Bligh'" <mjbligh@us.ibm.com>, akpm@osdl.org,
       "'Ingo Molnar'" <mingo@elte.hu>
Subject: Re: 2.6.5-rc3-mm4 x86_64 sched domains patch 
In-reply-to: Your message of "Sun, 11 Apr 2004 01:57:10 PDT."
             <200404110857.BIS60109@ms6.netsolmail.com> 
Date: Sun, 11 Apr 2004 02:57:42 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Can SLIT/SRAT be used here to define topology for the generic case?
    
    SRAT is being used by i386 to build zonelists, but not for the scheduler -
    any good reason why?

I can think of some possible reasons, but I'm not familiar with SLIT/SRAT
... can you describe it for me?

Rick
