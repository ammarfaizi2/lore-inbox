Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbTCSXGZ>; Wed, 19 Mar 2003 18:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbTCSXGZ>; Wed, 19 Mar 2003 18:06:25 -0500
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:1012
	"EHLO flat") by vger.kernel.org with ESMTP id <S261274AbTCSXGY>;
	Wed, 19 Mar 2003 18:06:24 -0500
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm2
Date: Wed, 19 Mar 2003 23:17:22 +0000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303192317.22103.cb-lkml@fish.zetnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm getting quite a lot of audio skips with this one. 2.5.64-mm8 was the 
last one I tested and it was very good.

2.5.64-mm8 works fine with pretty much any thud load I throw at it, but thud 
3 is enough to cause some skips with 2.5.65-mm2. Thud 5 causes serious 
starvation problems to the whole desktop.

Charlie



