Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbUCEFrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 00:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUCEFrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 00:47:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:37833 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262216AbUCEFrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 00:47:32 -0500
Subject: Re: problem with cache flush routine for G5?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <404812A2.70207@nortelnetworks.com>
References: <40479A50.9090605@nortelnetworks.com>
	 <1078444268.5698.27.camel@gaston>  <4047CBB3.9050608@nortelnetworks.com>
	 <1078452637.5700.45.camel@gaston>  <404812A2.70207@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1078465612.5704.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 16:46:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Assuming that I really did want to flush the whole cache, how would I go 
> about doing that from userspace? 

I don't think you can do it reliably, but again, that do not make
sense, so please check with those folks what's exactly going on.



