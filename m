Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVIALUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVIALUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVIALUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:20:48 -0400
Received: from main.gmane.org ([80.91.229.2]:48095 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932145AbVIALUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:20:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Neal Becker <ndbecker2@gmail.com>
Subject: via hardware accelerated crypto support
Date: Thu, 01 Sep 2005 07:07:10 -0400
Message-ID: <df6nb3$k3g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: nat-expu-252-47.hns.com
User-Agent: KNode/0.9.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't been following linux kernel development for a while, so I'm not
sure what the status is.  I noticed that there is now crypto support in the
kernel, including e.g. AES.  I would like to use hardware acceleration
where available, e.g., VIA EPIA.  Does the current kernel crypto support
include hardware acceleration, or is there any projects working on this?

