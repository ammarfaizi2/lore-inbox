Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTE1E5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbTE1E5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:57:31 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:33474 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S264507AbTE1E5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:57:30 -0400
Message-ID: <3ED444D0.8050407@shemesh.biz>
Date: Wed, 28 May 2003 08:10:40 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030521 Debian/1.3.1-1
X-Accept-Language: en, he
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: laptopkernel-2.4.21-rc4-laptop1 released
References: <20030527211346.11bed9c1.hanno@gmx.de>
In-Reply-To: <20030527211346.11bed9c1.hanno@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanno Böck wrote:

>Hello,
>
>I have started a project to create a kernel-patch containing various
>laptop-specific things.
>Especially it contains acpi, software suspend, supermount and some
>hardware compatibility patches.
>
>Our goal is to create a kernel that runs all hardware found in current
>laptops.
>If you have laptop-specific patches you think that should be in
>laptopkernel, contact us or submit them through savannahs patch-tracker.
>
>Full list of patches below, it can be downloaded at
>http://savannah.nongnu.org/projects/laptopkernel/
>  
>
Have you considered http://tpctl.sourceforge.net/tpctlhome.htm for 
thinkpads? There is also an alternative driver called "thinkpad", but I 
only know of it from the debian package, and they don't give the 
project's homepage there.

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


