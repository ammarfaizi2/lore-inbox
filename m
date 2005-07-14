Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVGNTTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVGNTTm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVGNTTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:19:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:50414 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261695AbVGNTSe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:18:34 -0400
Subject: Re: [RFC][PATCH] split PCI probing code [1/9]
From: John Rose <johnrose@austin.ibm.com>
To: Adam Belay <abelay@novell.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <1121331304.3398.89.camel@localhost.localdomain>
References: <1121331304.3398.89.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1121368467.9265.5.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 14 Jul 2005 14:14:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like it.  I'm a little hung up on the fact that actual device probing
happens in config.c rather than probe.c (if I'm correct).  Regardless,
this patch set cleans things up nicely.

John

