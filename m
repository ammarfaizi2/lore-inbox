Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTKBHLk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 02:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTKBHLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 02:11:40 -0500
Received: from adsl-64-175-243-181.dsl.sntc01.pacbell.net ([64.175.243.181]:22800
	"EHLO top.worldcontrol.com") by vger.kernel.org with ESMTP
	id S261492AbTKBHLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 02:11:39 -0500
From: brian@worldcontrol.com
Date: Sat, 1 Nov 2003 23:23:23 -0800
To: linux-kernel@vger.kernel.org
Subject: C3 compiled 2.4.20 kernel blows up on EPIA M
Message-ID: <20031102072323.GA7910@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a VIA EPIA M motherboard.

http://www.viavpsd.com/product/epia_m_spec.jsp?motherboardId=81

A 2.4.20 gentoo-sources kernel compiled with
CONFIG_MCYRIXIII blows up during boot.  Basically just after
hitting return on grub the screen turns to all blue 'V's and
then the acts like someone pushed the reset button.

386 and 586 kernels work fine.

I'm running gcc 3.2.3




-- 
Brian Litzinger
