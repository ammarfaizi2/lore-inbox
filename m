Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273015AbTGaMXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 08:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273017AbTGaMXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 08:23:38 -0400
Received: from foo.gazonk.org ([213.212.13.120]:4529 "HELO gazonk.org")
	by vger.kernel.org with SMTP id S273015AbTGaMXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 08:23:37 -0400
Date: Thu, 31 Jul 2003 14:23:34 +0200 (CEST)
From: Jonas Bofjall <j-lnxk@gazonk.org>
X-X-Sender: jonas@gazonk.org
To: Ivan Gyurdiev <ivg2@cornell.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: FYI: TCQ ReiserFS Corruption on 2.6.0-test1-mm2
In-Reply-To: <3F25761D.5030602@cornell.edu>
Message-ID: <Pine.LNX.4.51.0307311411440.3948@gazonk.org>
References: <Pine.LNX.4.51.0307281231590.29434@gazonk.org> <3F25761D.5030602@cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >> I use an IBM Deskstar 180GB IDE disk and tried out TCQ on
 > What TCQ queue depth? I'm curious, since I had *exactly* the same
 > happen to me, but only with depth 8 queue. Wondering if there is a

Yes, I only tried depth 8. I'll try another as soon as get all
data off the disk to a safer place :)
