Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270623AbTGUREB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270624AbTGUREA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:04:00 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:3085 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270623AbTGURDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:03:13 -0400
Date: Mon, 21 Jul 2003 18:18:14 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: "Sam (Uli) Freed" <sam@freed.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 does locks up VGA and keyboard
In-Reply-To: <3F1C1D66.1080409@freed.net>
Message-ID: <Pine.LNX.4.44.0307211817060.10689-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> here it is!

Your using a 2.4.X configuration for a 2.5.X kernel. You need to run the 
configurator for 2.5.X and set stuff up. The configurations have changed 
to much to just drop in a 2.4.X config. 

