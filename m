Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbUL3RV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUL3RV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 12:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUL3RV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 12:21:58 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:23149 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261676AbUL3RV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 12:21:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kaZsqHkor4UcOwvdkzxwFm9zohLDdPEGfiFSfZawDX2fgdWmqEbljGEI0xW0LLPkbNjzUlzSU/AiQvQCi+qbgGFBWlC012sAki+enDlVorrYx0jDd/+14nl4MqL0boX3fzS+4EECBjaIyqnugSCEkAYGcAcMCPNFK6MWpy2mbWM=
Message-ID: <9e4733910412300918750b47e8@mail.gmail.com>
Date: Thu, 30 Dec 2004 12:18:24 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: [bk pull] drm core/personality split
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <21d7e997041229234860454564@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0412300733380.25314@skynet>
	 <21d7e997041229234860454564@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 18:48:25 +1100, Dave Airlie <airlied@gmail.com> wrote:
> > of .h files to .c files and removes all the DRM() macros.

Does this include the changes to get rid of intermodule too?

-- 
Jon Smirl
jonsmirl@gmail.com
