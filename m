Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTI3Nbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbTI3Nbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:31:41 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:56119 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261438AbTI3Nbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:31:39 -0400
Date: Tue, 30 Sep 2003 14:31:13 +0100
From: Dave Jones <davej@redhat.com>
To: John Bradford <john@grabjohn.com>
Cc: Jamie Lokier <jamie@shareable.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030930133113.GC23333@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Bradford <john@grabjohn.com>,
	Jamie Lokier <jamie@shareable.org>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 09:17:16AM +0100, John Bradford wrote:
 
 > Of course a kernel compiled strictly for 386s may seem to boot on an
 > Athlon but not work properly.  So what?  Just don't run the 'wrong'
 > kernel.

Wrong answer. How do you intend to install Linux when a distro boot
kernel is compiled for lowest-common-denominator (386), and is the
'wrong' kernel for an Athlon ?

We hashed this argument out a week or so ago, it seems the message
didn't get across. YOU CAN NOT DISABLE ERRATA WORKAROUNDS IN A KERNEL
THAT MAY POSSIBLY BOOT ON HARDWARE THAT WORKAROUND IS FOR.

clearer ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
