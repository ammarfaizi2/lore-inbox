Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVBRRHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVBRRHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVBRRH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:07:29 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:5992 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261420AbVBRRHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:07:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=gZUy6Q1nv+BrdrW9KZcLZnnpmZ0v5ZVL5r95p2CL1VaZ0IBAfmKouLXD8ePpNwNu3DnMl3OO1r52/miX4HMNfYaFQN6tiq4nyHypHuH7xsXGjy7cjJrTFbgYNrGvHPQDzKrdERbBk12TSmwdvMXY1aXxzGAhrbpnjWMXzDaWZ/8=
From: Marc Cramdal <marc.cramdal@gmail.com>
Reply-To: marc.cramdal@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Sis760 chipset support
Date: Fri, 18 Feb 2005 19:07:16 +0100
User-Agent: KMail/1.7.92
References: <4213AB2B.2050604@giesskaennchen.de>
In-Reply-To: <4213AB2B.2050604@giesskaennchen.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200502181907.16586.marc.cramdal@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can't make agpgart working (even when trying the agp_try_unsupported) 
option. I have an AMD64 3000+ with a Sis760 chipset and agp doesn't seem to 
be supported : I only get this with dmesg : "Linux agpgart interface v0.100 
(c) Dave Jones". That's all...

So, is Sis760 chipset supported for agpgart under linux kernel ? if not, is 
there plan to be, tweaks to do (I even tried the Sis Chipset driver 
for !x86_64 by removing this entry in KConfig ... ) ?

Marc
