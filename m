Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbULGXAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbULGXAN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 18:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbULGXAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 18:00:12 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:57245 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261931AbULGXAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 18:00:07 -0500
Date: Tue, 7 Dec 2004 23:59:32 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>,
       Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041207225932.GB12030@mail.muni.cz>
References: <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org> <20041202231837.GB15185@mail.muni.cz> <20041202161839.736352c2.akpm@osdl.org> <20041203121129.GC27716@mail.muni.cz> <41B6343A.9060601@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41B6343A.9060601@cyberone.com.au>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 09:52:42AM +1100, Nick Piggin wrote:
> You're using 2.6.9, right? 2.6.10 should be better in this regard.

Yes, 2.6.9. I'm waiting for 2.6.10 final.

I tried also 2.6.10-rc1-mm3 but there was problably some memory corruption as
/proc/loadavg displayed almost random load in range 0-2000.
(according to http://undomiel1.ics.muni.cz/mrtg/load_1m.png)

-- 
Luká¹ Hejtmánek
