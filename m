Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVBWQaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVBWQaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 11:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVBWQaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 11:30:15 -0500
Received: from peabody.ximian.com ([130.57.169.10]:38317 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261495AbVBWQaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 11:30:10 -0500
Subject: Re: 2.6.11-rc4-mm1
From: Robert Love <rml@novell.com>
To: Mathieu Segaud <Mathieu.Segaud@crans.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <87psyredww.fsf@barad-dur.crans.org>
References: <20050223014233.6710fd73.akpm@osdl.org>
	 <87psyredww.fsf@barad-dur.crans.org>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 11:32:34 -0500
Message-Id: <1109176354.27403.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 12:03 +0100, Mathieu Segaud wrote:

> it is the latest Robert Love posted against -mm kernels, but in
> inotify_ignore():

I posted an updated patch last Friday, which fixed this.

Anyhow, this is the correct fix.

Signed-off-by: Robert Love <rml@novell.com>

Thanks,

	Robert Love


