Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292664AbSBZSfY>; Tue, 26 Feb 2002 13:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292659AbSBZSeh>; Tue, 26 Feb 2002 13:34:37 -0500
Received: from pC19F471E.dip.t-dialin.net ([193.159.71.30]:37344 "EHLO
	artus.fbunet.de") by vger.kernel.org with ESMTP id <S292420AbSBZSdF>;
	Tue, 26 Feb 2002 13:33:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fridtjof Busse <fridtjof.busse@gmx.de>
Message-Id: <200202261928.32383@fbunet.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [2.4.18-ac1] Unable to mount root fs
Date: Tue, 26 Feb 2002 19:33:27 +0100
In-Reply-To: <200202261722.13431@fbunet.de> <200202261907.20103@fbunet.de> <20020226181559.GQ4393@matchmail.com>
In-Reply-To: <20020226181559.GQ4393@matchmail.com>
Cc: linux-kernel@vger.kernel.org
X-OS: Linux on i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26. February 2002 19:15, Mike Fedyk wrote:
> > # CONFIG_BLK_DEV_PDC202XX is not set
>
> Here you go.  Promise IDE is not compiled into the kernel.

But why does the 2.4.18 work then?
I also didn't compile it with # CONFIG_BLK_DEV_PDC202XX

-- 
Fridtjof Busse
"We're thinking about upgrading from SunOS 4.1.1 to SunOS 3.5." 
-- Henry Spencer 

