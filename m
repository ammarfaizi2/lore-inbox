Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbUKRG0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbUKRG0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbUKRG0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:26:21 -0500
Received: from pop.gmx.de ([213.165.64.20]:52151 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262613AbUKRG0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:26:19 -0500
X-Authenticated: #20450766
Date: Thu, 18 Nov 2004 07:25:34 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [ACPI] Re: system slow since ~ 2.6.7
In-Reply-To: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
Message-ID: <Pine.LNX.4.60.0411180722390.3577@poirot.grange>
References: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Guennadi Liakhovetski wrote:

> I've been running until now 2.6.3 without problem. I had a test 2.6.7 
> kernel with reiserfs debugging enabled, and indeed it is running slow. Now 
> I compiled 2.6.9 without reiserfs debugging, but it is still slow... In 

Indeed, booting with "acpi=off" brings the system back to normal under 
2.6.9. I'll try to see if I can norrow it down (after Saturday - I'm away 
for 2 days now), but ideas are welcome.

Thanks
Guennadi
---
Guennadi Liakhovetski

