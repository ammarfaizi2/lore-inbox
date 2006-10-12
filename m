Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWJLPmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWJLPmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWJLPmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:42:11 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:57355 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932628AbWJLPmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:42:10 -0400
Date: Thu, 12 Oct 2006 17:42:14 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon/abituguru: handle sysfs errors
Message-Id: <20061012174214.81afe0b2.khali@linux-fr.org>
In-Reply-To: <200610120031.20097.dtor@insightbb.com>
References: <20061010065359.GA21576@havoc.gtf.org>
	<452B6569.7050404@hhs.nl>
	<20061010113441.24b19b99.khali@linux-fr.org>
	<200610120031.20097.dtor@insightbb.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Dmitry Torokhov wrote:
> I know I sound like a roken record but this driver would benefit from
> using attribute_group.

What about sending a patch then?

-- 
Jean Delvare
