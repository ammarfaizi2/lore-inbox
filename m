Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271106AbUJVBsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271106AbUJVBsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271176AbUJVBqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:46:21 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:50307 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S271161AbUJVBjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:39:25 -0400
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6003287A2A@scsmsx403.amr.corp.intel.com>
References: <88056F38E9E48644A0F562A38C64FB6003287A2A@scsmsx403.amr.corp.intel.com>
Date: Fri, 22 Oct 2004 02:39:21 +0100
Message-Id: <E1CKoOn-0004Jv-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:

Hi,

> Even I thought so. But, with the emulator it doesn't hang. It brings 
> back my video. I double checked this using another vm86 emulator too. 
> No hang even there. I couldn't figure out why Ole's patch won't work 
> though. Right now I am using call_usermodehelper() to call the 
> emulator during resume and the video comes back just fine on this 
> system where Ole's patch didn't work.

Is it possible to get this patch and code off you? I'd be interested in
testing this solution on various bits of hardware I've been working on.

Thanks,
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
