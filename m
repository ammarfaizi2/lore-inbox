Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271724AbTGXREG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271725AbTGXREG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:04:06 -0400
Received: from dhcp538.linuxsymposium.org ([209.151.10.36]:14464 "EHLO gaston")
	by vger.kernel.org with ESMTP id S271724AbTGXRDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:03:32 -0400
Subject: Re: 2.6.0-test1-ac3 and PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Wojciech \"Sas\" Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0307241335520.24052-200000@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.44L.0307241335520.24052-200000@alpha.zarz.agh.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059067110.537.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 24 Jul 2003 13:18:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Proper fix is to set it to 0 actually, I'll send patches to Linus when
I'm back from OLS, along with the longstanding driver updates

Ben.
