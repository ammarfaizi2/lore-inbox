Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbTF1UAu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTF1UAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:00:50 -0400
Received: from front2.netvisao.pt ([213.228.128.57]:28868 "HELO
	front2.netvisao.pt") by vger.kernel.org with SMTP id S265374AbTF1UAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:00:50 -0400
Date: Sat, 28 Jun 2003 21:15:05 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Asus CD-S520/A kernel I/O error
Message-ID: <20030628201505.GA10194@deneb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Marco Ferra <marcoferra@netvisao.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You were right once more.  I was using the cdrecord version 1.10 shiped
with Debian 3.0 (woody).  After compiling the latest
cdrtools-2.00.3.tar.gz and grasping the manpage I could see the -raw96r
option.  Now the final test is to burn the cd.  But I'm sure that all be
fine.

Once again I can't thank you enough.  This 'strange' error have been killing
my brain cells all day.

My best regards, Marco.
