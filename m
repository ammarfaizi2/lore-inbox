Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbUJZOd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbUJZOd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUJZOd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:33:57 -0400
Received: from peabody.ximian.com ([130.57.169.10]:48872 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262282AbUJZOdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:33:55 -0400
Subject: Re: [patch] make dnotify a configure-time option
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041026013026.6b65bd24.akpm@osdl.org>
References: <1098765164.6034.38.camel@localhost>
	 <20041025214947.63031519.akpm@osdl.org>
	 <1098767891.6034.50.camel@localhost>
	 <20041026013026.6b65bd24.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 10:34:26 -0400
Message-Id: <1098801266.6034.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 01:30 -0700, Andrew Morton wrote:

> I don't think we want people accidentally disabling dnotify and making
> kernels which don't implement the standard kernel API.  So...

Fine with me.

Thanks!

	Robert Love


