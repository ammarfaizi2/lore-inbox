Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTFDKut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTFDKut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:50:49 -0400
Received: from axion.xs4all.nl ([213.84.8.90]:54314 "EHLO axion.demon.nl")
	by vger.kernel.org with ESMTP id S263199AbTFDKus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:50:48 -0400
Date: Wed, 4 Jun 2003 13:04:15 +0200
From: Monchi Abbad <kernel@axion.demon.nl>
To: linux-kernel@vger.kernel.org
Subject: ever since 2.5.70 no isapnp for cs4236+
Message-ID: <20030604110415.GA15922@axion.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ever since kernel 2.5.70 I have a problem with the kernel freezing upon initing the cs4236+
 sound card, whereas previously there was no such problem. Now I get the following message:

Advanced Linux Sound Architecture Driver Version 0.9.4 (Sat May 31 13:37:06 2003 UTC).
can't register device seq
specify port
isapnp detection failed and probing for CS4236+ is not supported

It says that probing for cs4236+ is not supported, previously this worked just fine though.


Monchi.
--
