Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUGFOU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUGFOU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 10:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUGFOU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 10:20:58 -0400
Received: from main.gmane.org ([80.91.224.249]:48546 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263962AbUGFOU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 10:20:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Volker Braun <volker.braun@physik.hu-berlin.de>
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Date: Tue, 06 Jul 2004 10:14:48 -0400
Message-ID: <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: carrot.hep.upenn.edu
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: linux-thinkpad@linux-thinkpad.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI S3 draws too much power on the T40/T41, this has been confirmed by
various people (so its not just mine). Suspended it lasts about 10h,
about twice as long as powered up. Supposed to be 1-2 weeks. 

I guess we should have filed a bug report a long time ago. I'll do that
now.

If anybody has any tips on how to debug this (debug a suspended machine
:-) I would like to know.

Best,
Volker


