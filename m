Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUDAT14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUDAT14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:27:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46031 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262870AbUDAT1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:27:53 -0500
Date: Thu, 1 Apr 2004 14:27:32 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: William Lee Irwin III <wli@holomorphy.com>, <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>, <kenneth.w.chen@intel.com>
Subject: Re: disable-cap-mlock
In-Reply-To: <20040401103425.03ba8aff.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0404011426150.30950-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Andrew Morton wrote:

> Using the security framework is neat.  There are currently large spinlock
> contention problems in avc_has_perm_noaudit() which I suspect will make
> SELinux problematic in some server environments.

This issue will be addressed soon.


- James
-- 
James Morris
<jmorris@redhat.com>


