Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTE2VJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTE2VJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:09:42 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:35826 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263056AbTE2VJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:09:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16086.31229.258838.80234@gargle.gargle.HOWL>
Date: Thu, 29 May 2003 17:22:05 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Downing, Thomas" <Thomas.Downing@ipc.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
In-Reply-To: <20030529103628.54d1e4a0.akpm@digeo.com>
References: <170EBA504C3AD511A3FE00508BB89A920221E5FF@exnanycmbx4.ipc.com>
	<20030529103628.54d1e4a0.akpm@digeo.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does 2.5.70-mm2 include the RAID1 patch posted by Niel?  I'm thinking
that maybe my problems in -mm1 and the oops I saw were more AS related
than RAID1, but I'm not sure.  I'll probably apply that Raid1 patch
and see how it goes.

Thanks for all your hard work Andrew!

John
