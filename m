Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUDAGtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 01:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUDAGtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 01:49:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:37864 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262750AbUDAGtu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 01:49:50 -0500
Date: Wed, 31 Mar 2004 22:49:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: "C.L. Tien - =?ISO-8859-1?B?X19fX19fX19f?=" <cltien@cmedia.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu,
       support@cmedia.com.tw
Subject: Re: ANN: cmpci 6.67 released
Message-Id: <20040331224943.2362ce4e.akpm@osdl.org>
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D403@cm-msg-02.cmedia.com.tw>
References: <92C0412E07F63549B2A2F2345D3DB515F7D403@cm-msg-02.cmedia.com.tw>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C.L. Tien - _________ <cltien@cmedia.com.tw> wrote:
>
> 
> Hi,
> 
> I made serveral changes for 6.64, the change are as following:

To what kernel do these patches apply?  Certainly not current 2.6.

If you intend to raise 2.6 patches, please ensure that they are against the
latest kernel.org kernel.  And please ensure that the patches are in `patch
-p1' form.  The headers should look like:

--- a/sound/oss/cmpci.c 22 Mar 2004 17:07:02 -0000      6.64
+++ a/sound/oss/cmpci.c 29 Mar 2004 22:58:49 -0000      6.65

Also, a single patch per email is preferred.

Thanks.
