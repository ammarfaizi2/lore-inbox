Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUIOVoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUIOVoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUIOVlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:41:47 -0400
Received: from peabody.ximian.com ([130.57.169.10]:4804 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267523AbUIOVkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:40:31 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Tim Hockin <thockin@hockin.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1095284330.3508.11.camel@localhost.localdomain>
References: <20040915034455.GB30747@kroah.com>
	 <20040915194018.GC24131@kroah.com>
	 <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915202234.GA18242@hockin.org>
	 <1095279985.23385.104.camel@betsy.boston.ximian.com>
	 <20040915203133.GA18812@hockin.org>
	 <1095280414.23385.108.camel@betsy.boston.ximian.com>
	 <20040915204754.GA19625@hockin.org>
	 <1095281358.23385.109.camel@betsy.boston.ximian.com>
	 <20040915205643.GA19875@hockin.org>  <20040915212322.GB25840@kroah.com>
	 <1095283589.23385.117.camel@betsy.boston.ximian.com>
	 <1095284330.3508.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 17:39:29 -0400
Message-Id: <1095284369.23385.125.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 23:38 +0200, Kay Sievers wrote:

> Anyone can watch the refcount on the fs-modules, they increment on every
> device claim. Is that a leak in your eyes too :)

Haha, Kay, rocking point.

	Robert Love


