Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTAJVLh>; Fri, 10 Jan 2003 16:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTAJVLh>; Fri, 10 Jan 2003 16:11:37 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:2952 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266064AbTAJVLg>; Fri, 10 Jan 2003 16:11:36 -0500
Date: Fri, 10 Jan 2003 22:20:18 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Derek Atkins <warlord@MIT.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
Message-ID: <20030110212018.GM10062@louise.pinerecords.com>
References: <sjmlm1t5489.fsf@kikki.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sjmlm1t5489.fsf@kikki.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [warlord@MIT.EDU]
> 
> PANIC: INIT: segmentation violation at 0x804a08c (code)! sleeping for 30 seconds!

I'm seeing the same problem with vanilla 2.5.56 booting in vmware
workstation 3.2.0.

-- 
Tomas Szepe <szepe@pinerecords.com>
