Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVAJD2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVAJD2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 22:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVAJD2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 22:28:21 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:64031 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262058AbVAJD2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 22:28:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EHfjqhsjR28bT4mQcC/XoBoQwxljAAj/94sA20rHq+eHwcP+JVwbnB8Q4QId5K+3u5VRZDs7JFdiCRggGMPTaW577WKAj8B4PoSYozkP51tJLDVZlwzE2KOr+WAfH2IFhsCghDNK9yStJZFiVC3ppUuAzfyVfx4IfjViB9q/mJY=
Message-ID: <9e47339105010919284cb0d5c3@mail.gmail.com>
Date: Sun, 9 Jan 2005 22:28:17 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@sgi.com>
Subject: Re: [PATCH] PCI rom.c cleanups
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <200501091530.47556.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501091530.47556.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me. 

I sent out another clean patch here:
http://lkml.org/lkml/2005/1/7/274


On Sun, 9 Jan 2005 15:30:46 -0800, Jesse Barnes <jbarnes@sgi.com> wrote:
> Greg, here's some whitespace and long line cleanup I wanted to do last time I
> touched rom.c, but forgot.  Does it look ok to you, Jon?
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> 
> Thanks,
> Jesse
> 
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
