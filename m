Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWEDWB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWEDWB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWEDWB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:01:59 -0400
Received: from web.bloglines.com ([65.214.39.152]:50325 "HELO
	blw06bos.io.askjeeves.info") by vger.kernel.org with SMTP
	id S1030269AbWEDWB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:01:59 -0400
Message-ID: <1146780118.931342476.15992.sendItem@bloglines.com>
Date: 4 May 2006 22:01:58 -0000
From: grfgguvf.29601511@bloglines.com
To: adaplas@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird framebuffer bug?
MIME-Version: 1.0
Content-Type: text/plain;charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Antonino A. Daplas <adaplas@gmail.com> wrote:
> And if you can't specify
the actual resolution with vesafb, try nvidiafb.

I have specified the actual
resolution. Text mode with vesafb fills the whole screen (and the on-screen
menu says 1024x768 which is the native resolution of the monitor). The screenshot
I took when using X via fbdev (set to 1024x768 too) while the displaying was
erroneous is 1024x768 as well. It somehow just doesn't reach the monitor in
that form.
