Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTJKK4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 06:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTJKK4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 06:56:42 -0400
Received: from tartutest.cyber.ee ([193.40.6.70]:1284 "EHLO tartutest.cyber.ee")
	by vger.kernel.org with ESMTP id S263273AbTJKK4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 06:56:42 -0400
From: Meelis Roos <mroos@linux.ee>
To: gmicsko@szintezis.hu, linux-kernel@vger.kernel.org
Subject: Re: [2.7 "thoughts"] V0.3
In-Reply-To: <1065853470.895.4.camel@sunshine>
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.6.0-test7 (i686))
Message-Id: <E1A8HQM-0008F5-0V@rhn.tartu-labor>
Date: Sat, 11 Oct 2003 13:56:38 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GM> How about The Vinum Volume Manager?

To the best of my understanding, Vinum is roughly equivalent of MD / LVM
verion 1. Since then, FreeBSD has moved to GEOM and Linux has moved to
LVM2 (device mapper). And device mapper and GEOM are again roughly
equivalent.

-- 
Meelis Roos (mroos@linux.ee)
