Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUIOU41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUIOU41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUIOUzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:55:02 -0400
Received: from peabody.ximian.com ([130.57.169.10]:37315 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267424AbUIOUuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:50:19 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040915204754.GA19625@hockin.org>
References: <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost>
	 <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com>
	 <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915202234.GA18242@hockin.org>
	 <1095279985.23385.104.camel@betsy.boston.ximian.com>
	 <20040915203133.GA18812@hockin.org>
	 <1095280414.23385.108.camel@betsy.boston.ximian.com>
	 <20040915204754.GA19625@hockin.org>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 16:49:18 -0400
Message-Id: <1095281358.23385.109.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 13:47 -0700, Tim Hockin wrote:

> Are you not sending it with some specific device as the source?  Or is it
> just coming from some abstract root kobject?

It comes the the physical device.

Is there really a specific issue that you are seeing?

	Robert Love


