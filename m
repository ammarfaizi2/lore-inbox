Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVCISyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVCISyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVCISyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:54:36 -0500
Received: from c-67-163-99-44.client.comcast.net ([67.163.99.44]:33934 "EHLO
	leaper.linuxtx.org") by vger.kernel.org with ESMTP id S262128AbVCISxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:53:32 -0500
Date: Wed, 9 Mar 2005 12:53:31 -0600
From: "Justin M. Forbes" <jmforbes@linuxtx.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.Stable and EXTRAVERSION
Message-ID: <20050309185331.GB19306@linuxtx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the new stable series kernels, the .x versioning is being added to
EXTRAVERSION.  This has traditionally been a space for local modification.
I know several distributions are using EXTRAVERSION for build numbers,
platform and assorted other information to differentiate their kernel
releases.
I would propose that the new stable series kernels move the .x version
information somewhere more official.  I certainly do not mind throwing
together a patch to support DOTVERSION or what ever people want to call it.
Is anyone opposed to such a change?

Thanks,
Justin M. Forbes
