Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbTELPXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTELPXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:23:09 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:46029 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262211AbTELPXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:23:08 -0400
Date: Mon, 12 May 2003 17:31:39 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Undo aic7xxx changes
Message-ID: <20030512153139.GA12275@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I today compiled  2.4.21-rc2 smp with aic79xx-linux-2.4-20030502-tar.gz 
and discovered no problems or hangs. (Tyan-S2665 with AIC-7902)

I haven't had any problems with the driver since I got this 
motherboard starting with aic79xx-linux-2.4-20030318-tar.gz 
and linux-2.4.21-pre5.

-- 
Regards Klaus
