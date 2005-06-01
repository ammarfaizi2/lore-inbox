Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVFARbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVFARbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVFARbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:31:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18173 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261478AbVFARa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:30:27 -0400
Date: Wed, 1 Jun 2005 10:30:11 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
cc: linux-kernel@vger.kernel.org
Subject: pi_test predicted results
In-Reply-To: <Pine.OSF.4.05.10506011709500.1707-100000@da410.phys.au.dk>
Message-ID: <Pine.LNX.4.44.0506011023480.5968-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	What would you predict the results of the pi test with --tasks 10 
and --depth 3 ?

	From the docmentation it looks like depth N adds N milliseconds to 
the locking latency . It seems like increasing the numbers of tasks would 
also increase the locking latency by M tasks == M milliseconds. But I 
thought I would ask to be sure..

Daniel

