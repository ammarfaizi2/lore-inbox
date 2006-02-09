Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWBIECX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWBIECX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWBIECX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:02:23 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:10845 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161008AbWBIECX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:02:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RhGOavZwkbas00EOrhHG4Y0JIiEuwBGzsXvVGuvQR9nhsZvLm3Y/d2PsQJ10EmCyFDldC65mNrgV3dl90fMMTMiMmRu69UMpQBkDDhSkVP/6WEVJTsA9W60Raw7uI63IRYhwT28u/roOwn2aPz4S9853GtwhQlZdxtV2TSqjum4=
Message-ID: <661de9470602082002o620a42feg7fadbec6430bfd78@mail.gmail.com>
Date: Thu, 9 Feb 2006 09:32:22 +0530
From: Balbir Singh <bsingharora@gmail.com>
To: Jan Dittmer <jdi@l4x.org>
Subject: Re: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. Have a nice day...
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, dev@sw.ru,
       jblunck@suse.de
In-Reply-To: <43EA73C9.7010101@l4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43E90573.8040305@l4x.org> <20060207162335.5304ae61.akpm@osdl.org>
	 <43E9A260.6000202@l4x.org>
	 <661de9470602081006p2a3132e8x2436de89e9395748@mail.gmail.com>
	 <43EA73C9.7010101@l4x.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the suggestion, but I couldn't reproduce it with a simple
> mount/umount and the partition in question is gone for good now. And I
> don't feel like risiking 450gb of data, even if I had a backup of the
> data...

Thats a smart thing to do.

Balbir
