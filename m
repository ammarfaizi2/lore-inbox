Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271903AbTGYDhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 23:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271904AbTGYDhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 23:37:07 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:62936 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S271903AbTGYDhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 23:37:05 -0400
Date: Thu, 24 Jul 2003 23:54:44 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: dbench has intermittent hang on 2.6.0-test1-ac2
Message-ID: <20030725035444.GA10288@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dbench 64 hung during a run using 2.6.0-test1-ac2 on ext3.

> I saw the same behavior on a dbench 32 run with 2.6.0-test1-ac1
> on reiserfs.

dbench did not hang in 50 runs on 2.6.0-test1 or 50 runs
on 2.6.0-test1-mm2 on the same machine with various filesystems.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

