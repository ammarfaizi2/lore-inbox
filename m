Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270036AbUIDDvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270036AbUIDDvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270038AbUIDDvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:51:22 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:33978 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270036AbUIDDvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:51:21 -0400
Message-ID: <9e4733910409032051717b28c0@mail.gmail.com>
Date: Fri, 3 Sep 2004 23:51:21 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: New proposed DRM interface design
Cc: Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409040158400.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0409040107190.18417@skynet>
	 <a728f9f904090317547ca21c15@mail.gmail.com>
	 <Pine.LNX.4.58.0409040158400.25475@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we work towards the merged DRM/fbdev goal the fbdev libraries are
going to become part of DRM. The libraries will be used pretty much
unchanged as it is the driver code that needs to be adjusted. How does
this play with the new DRM model?
