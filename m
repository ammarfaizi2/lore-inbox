Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbULBTyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbULBTyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbULBTyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:54:54 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:59050 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261741AbULBTyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:54:52 -0500
Date: Thu, 2 Dec 2004 20:54:22 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Stefan Schmidt <zaphodb@zaphods.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041202195422.GA20771@mail.muni.cz>
References: <20041109203348.GD8414@logos.cnet> <20041110212818.GC25410@mail.muni.cz> <20041110181148.GA12867@logos.cnet> <20041111214435.GB29112@mail.muni.cz> <4194A7F9.5080503@cyberone.com.au> <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041121024226.GK4999@zaphods.net>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found out that 2.6.6-bk4 kernel is OK. 

Bugs in 2.6.9 results e.g. in a blocking select on the network socket :(

-- 
Luká¹ Hejtmánek
