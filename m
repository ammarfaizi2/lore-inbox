Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbTEFSPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTEFSN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:13:26 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:28421 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263972AbTEFSNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:13:00 -0400
Date: Tue, 6 May 2003 19:25:31 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Reid Hekman <hekman@ideaone.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 neofb screen corruption leaving X
In-Reply-To: <1052193973.31970.3.camel@artemis>
Message-ID: <Pine.LNX.4.44.0305061924560.7110-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Description: The console is "blown up" upon leaving X with neofb

Do you have the UseFBDev flag set in XF86Config? This should fix the 
problem.


