Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTFMJcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 05:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTFMJcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 05:32:12 -0400
Received: from mail.ithnet.com ([217.64.64.8]:2574 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265287AbTFMJcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 05:32:09 -0400
Date: Fri, 13 Jun 2003 11:45:31 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org, willy@w.ods.org,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030613114531.2b7235e7.skraw@ithnet.com>
In-Reply-To: <16103.39056.810025.975744@gargle.gargle.HOWL>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

this is the second day of stress-testing pure rc8 in SMP, apic mode. Today
everything is fine, no freeze, no data corruption.

current standings:

2 days continuous test, one file data corruption on day 1

Regards,
Stephan
