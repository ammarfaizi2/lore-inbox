Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbTKHAmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTKGWE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:04:28 -0500
Received: from 217-124-4-154.dialup.nuria.telefonica-data.net ([217.124.4.154]:48256
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S264624AbTKGUOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 15:14:49 -0500
Date: Fri, 7 Nov 2003 21:14:44 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm1 and mm2: Extremely slow mouse
Message-ID: <20031107201444.GA5110@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031107014720.28888.qmail@web20902.mail.yahoo.com> <20031107044652.2325.qmail@web20903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031107044652.2325.qmail@web20903.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 06 November 2003, at 20:46:52 -0800,
Brandon Stewart wrote:

> Simple solution. Add psmouse_resolution=200 to the boot options. No skip,
> smooth mouse. All is good.
> 
If I recall correctly someone suggested passing "psmouse_noext=1" to the
kernel to fix the reported problem in many cases. It works for me.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test9-mm1)
