Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbVDPRsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbVDPRsj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 13:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbVDPRsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 13:48:39 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:9936 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262713AbVDPRsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 13:48:38 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: Re: touch screen driver --working?
Date: Sat, 16 Apr 2005 19:48:20 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504161948.20160.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you should have a look at http://linux.chapter7.ch/touchkit/
it contains a howto and a calibration progam. it's centered around
touchscreens with eGalax controllers but the info there is valid for
about every touchscreen as long as the driver uses the linux input
subsystem (it really should).

hope this helps. rgds
-daniel

