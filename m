Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUIPBFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUIPBFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUIPBCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:02:02 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:59867 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S267435AbUIPA6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 20:58:17 -0400
Subject: Re: The ultimate TOE design
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       paul@clubi.ie, netdev@oss.sgi.com, leonid.grossman@s2io.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <4148B2E5.50106@pobox.com>
References: <4148991B.9050200@pobox.com>
	 <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
	 <1095275660.20569.0.camel@localhost.localdomain>	<4148A90F.80003@pobox.com>
	 <20040915140123.14185ede.davem@davemloft.net>
	 <20040915210818.GA22649@havoc.gtf.org>
	 <20040915141346.5c5e5377.davem@davemloft.net>  <4148B2E5.50106@pobox.com>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1095296279.1064.80.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Sep 2004 20:57:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,
You are only allowed to start a TOE thread only every six months ;->

On a serious note, I think that PCI-express (if it lives upto its
expectation) will demolish dreams of a lot of these TOE investments.
Our problem is NOT the CPU right now (80% idle processing 450Kpps
forwarding). Bus and memory distance/latency are. If intel would get rid
of the big conspiracy in the form of chipset division and just integrate
the MC like AMD is, we'll be on our our way to kill TOE and a lot of the
network processors (like the IXP). Dang, running Linux is more exciting
than microcoding things to fit into a 2Kword program store. 

I rest my canadiana $.02 

cheers,
jamal

