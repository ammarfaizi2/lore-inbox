Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFATIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFATIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFATDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:03:25 -0400
Received: from smtp19.wxs.nl ([195.121.6.15]:35044 "EHLO smtp19.wxs.nl")
	by vger.kernel.org with ESMTP id S261250AbVFATBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:01:35 -0400
Date: Wed, 01 Jun 2005 21:01:31 +0200
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: Re: Problem compiling zr36120 on kernel2.6.12-r5-mm2
In-reply-to: <a728f9f905060111492301462@mail.gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <1117652490.2726.4.camel@tux.lan>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <429DC137.30705@brturbo.com.br>
 <a728f9f905060111492301462@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 20:49, Alex Deucher wrote:
> The zoran stuff is supported by another project with their own source
> tree.  It may make sense to merge their latest code into v4l cvs, but
> I don't know how they feel about that.  The same can be said for the
> ivtv stuff and other assorted v4l projects.

It's mostly unmaintained (although the MAINTAINERS file still mentions a
five-year-old entry) and broken; you must be confused with the zr36067
driver, which works perfectly fine, is being (passively) maintained by
me and which has a copy of the relevant files from the kernel sources in
the CVS of mjpegtools.

Ronald

-- 
Ronald S. Bultje <rbultje@ronald.bitfreak.net>

