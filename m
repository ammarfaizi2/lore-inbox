Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTEQHyV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 03:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTEQHyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 03:54:21 -0400
Received: from gate.in-addr.de ([212.8.193.158]:33980 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261292AbTEQHyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 03:54:20 -0400
Date: Sat, 17 May 2003 10:05:30 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix, v4
Message-ID: <20030517080529.GJ6985@marowsky-bree.de>
References: <20030516161717.1e629364.akpm@digeo.com> <20030516161753.08470617.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030516161753.08470617.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-05-16T16:17:53,
   Andrew Morton <akpm@digeo.com> said:

> drivers/block/
> --------------

Last time I looked at the multipath code (2.5.50 or so) it also looked
pretty broken; I plan to port forward the changes we did on 2.4 before
KS.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
