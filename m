Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbTIJJEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTIJJEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:04:22 -0400
Received: from pc1-cmbg5-6-cust223.cmbg.cable.ntl.com ([81.104.201.223]:42992
	"EHLO flat") by vger.kernel.org with ESMTP id S264835AbTIJJEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:04:22 -0400
Date: Wed, 10 Sep 2003 10:04:20 +0100
From: cb-lkml@fish.zetnet.co.uk
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE: Fix Power Management request race on resume
Message-ID: <20030910090419.GA3673@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I applied this patch to 2.6.0-test5 and still have this problem:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106218353005043&w=2

Charlie
