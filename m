Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbTD1Vit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbTD1Vis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 17:38:48 -0400
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:57500 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261319AbTD1Vis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 17:38:48 -0400
Date: Mon, 28 Apr 2003 17:58:24 -0400
To: piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68 and 2.5.68-mm2
Message-ID: <20030428215824.GA20168@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A run with deadline on mm would be nice to see. 

I've just kicked off elevator=deadline on 2.5.68-mm2.

> Are you using TCQ by any chance? If so, what do the results look
> like with TCQ off?

Any idea how to turn off TCQ with the qlogicisp driver?

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

