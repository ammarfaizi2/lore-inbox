Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTEPAlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTEPAlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:41:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7081 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264311AbTEPAlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:41:36 -0400
Date: Thu, 15 May 2003 17:53:48 -0700 (PDT)
Message-Id: <20030515.175348.45895365.davem@redhat.com>
To: akpm@digeo.com
Cc: lists@mdiehl.de, linux-kernel@vger.kernel.org, jt@hpl.hp.com
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <PAO-EX01Cv3uS7sBdxk00001183@pao-ex01.pao.digeo.com>
References: <PAO-EX01Cv3uS7sBdxk00001183@pao-ex01.pao.digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Way too invasive, and this adds bugs to the ipmr.c code.

I'd much rather see /sbin/hotplug be able to handle things
asynchonously.
