Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273983AbRJDNMa>; Thu, 4 Oct 2001 09:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273985AbRJDNMU>; Thu, 4 Oct 2001 09:12:20 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:16010
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S273983AbRJDNMK>; Thu, 4 Oct 2001 09:12:10 -0400
Date: Thu, 04 Oct 2001 09:12:27 -0400
From: Chris Mason <mason@suse.com>
To: Ed Tomlinson <tomlins@CAM.ORG>, reiserfs-list@namesys.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] [BUG] opps in 2.4.11-pre2 + prempt patch
Message-ID: <213850000.1002201147@tiny>
In-Reply-To: <20011003230330.508E91104F@oscar.casa.dyndns.org>
In-Reply-To: <20011003230330.508E91104F@oscar.casa.dyndns.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, October 03, 2001 07:03:29 PM -0400 Ed Tomlinson
<tomlins@CAM.ORG> wrote:

> Hi,
> 
> Does this point at anything?  This happened running dbench with
> 2.4.11-pre2 working on a reiserfs on an LVM (1.01-rc2) volume.  The
> prempt patch is also applied.

I suspect it is a bad interaction with the prempt patch.  I'm using
reiserfs on pre2 without problems here.  It could be lvm-rc2, but I doubt
it.

-chris

