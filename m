Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVCCWpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVCCWpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVCCWpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:45:15 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:38865 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261267AbVCCWob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:44:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gez6yfpSi9GCE9c61NIgrnF3sk9bz0Bhbc+YrtawWoNsP07fSCvcV6Mdi5BSOgSsyq6WAgBqneKSxfZjTSvE9kwbtuJJrkrocRfE80tT6ed8o2DYbVyPUEFdRzTAoP1ZMYJNAYKOVqCeQOTv1zg9BjtO8YxmaGEcNcE2C57S3sg=
Message-ID: <9e47339105030314442a2b4e43@mail.gmail.com>
Date: Thu, 3 Mar 2005 17:44:30 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [2.6 patch] drivers/video/: more cleanups
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050303210119.GK4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050303210119.GK4608@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005 22:01:19 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch contains cleanups including the following:

Are you cleaning up all of that annoying trailing whitespace too? It
is always giving me problems on diffs.

-- 
Jon Smirl
jonsmirl@gmail.com
