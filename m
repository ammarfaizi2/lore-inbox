Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUHFVIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUHFVIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268318AbUHFVIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:08:39 -0400
Received: from peabody.ximian.com ([130.57.169.10]:62082 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268309AbUHFVHc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:07:32 -0400
Subject: Re: [patch] add kobject_get_path
From: Robert Love <rml@ximian.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1091825763.7939.84.camel@betsy>
References: <1091824013.7939.66.camel@betsy>
	 <1091824903.7939.80.camel@betsy>  <20040806205022.GA26135@kroah.com>
	 <1091825763.7939.84.camel@betsy>
Content-Type: text/plain
Date: Fri, 06 Aug 2004 17:07:28 -0400
Message-Id: <1091826448.7933.85.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 16:56 -0400, Robert Love wrote:

> I presume these functions are still meaningful if !CONFIG_HOTPLUG?

Compiles, at least.  Just tested.

	Robert Love


