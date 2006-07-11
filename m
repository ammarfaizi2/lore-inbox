Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWGKRA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWGKRA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWGKRA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:00:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36051 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751087AbWGKRAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:00:55 -0400
Subject: Re: Linux v2.6.18-rc1
From: Steve Fox <drfickle@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1152566236.1576.100.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <pan.2006.07.07.15.41.35.528827@us.ibm.com>
	 <1152441242.4128.33.camel@localhost.localdomain>
	 <1152537672.28828.4.camel@farscape.rchland.ibm.com>
	 <1152542413.27368.131.camel@localhost.localdomain>
	 <1152566236.1576.100.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 12:00:52 -0500
Message-Id: <1152637252.2853.5.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 07:17 +1000, Benjamin Herrenschmidt wrote:

> it's most certainly an irq problem as I just rewrote the irq logic of
> powerpc :) There have been some issues and I've just sent some new
> patches fixing them, let's see if that's enough. I'll give a js20 a try
> today at work.

FWIW, I tried applying the 3 non-Apple-specific patches posted on 7/10
but this didn't help.

-- 

Steve Fox
IBM Linux Technology Center
