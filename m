Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTEKPOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 11:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTEKPOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 11:14:39 -0400
Received: from franka.aracnet.com ([216.99.193.44]:5789 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261624AbTEKPOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 11:14:39 -0400
Date: Sun, 11 May 2003 06:12:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.69-mjb1
Message-ID: <11260000.1052658777@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.50.0305110932400.15337-100000@montezuma.mastecende.com>
References: <9380000.1052624649@[10.10.2.4]> <Pine.LNX.4.50.0305110932400.15337-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any particular reason why CONFIG_PREEMPT is commented out?

Yeah, 'cause it's broken ;-) If someone can figure out what broke it,
(something in my tree) I'll turn it back on. Else it stays disabled
as a footguard for poor innocents ;-)

M.

