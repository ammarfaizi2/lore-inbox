Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTFONOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 09:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTFONOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 09:14:18 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:56194 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262202AbTFONOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 09:14:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16108.29715.977015.425380@gargle.gargle.HOWL>
Date: Sun, 15 Jun 2003 09:26:43 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, stoffel@lucent.com, gibbs@scsiguy.com,
       willy@w.ods.org, marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030615145602.089728b3.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030615145602.089728b3.skraw@ithnet.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephan> this is the fourth day of stress-testing pure rc8/2.4.21 in
Stephan> SMP, apic mode. Today another corruption happened.
 
Stephan> current standings:
 
Stephan> 4 days continuous test, 
Stephan> one file data corruption on day 1
Stephan> one file data corruption on day 4

Can you define corruption?  Can you tell us what commands you are
using to generate the data which is written to tape?  

John

