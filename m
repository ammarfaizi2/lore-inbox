Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262647AbTCTV6h>; Thu, 20 Mar 2003 16:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbTCTV6g>; Thu, 20 Mar 2003 16:58:36 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:26504 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S262648AbTCTV6P>; Thu, 20 Mar 2003 16:58:15 -0500
Date: Thu, 20 Mar 2003 14:09:02 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t and major/minor split
Message-ID: <20030320220901.GR2835@ca-server1.us.oracle.com>
References: <b5dckh$lv1$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5dckh$lv1$1@cesium.transmeta.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 01:42:41PM -0800, H. Peter Anvin wrote:
> b) In order to support NFSv2 and other filesystems which only support
>    a 32-bit dev_t, I suggest we stay within a (12,20)-bit range for as

	Hmm, I guess that means dropping ext2/3 for / ;-(

Joel

-- 

"Nothing is wrong with California that a rise in the ocean level
 wouldn't cure."
        - Ross MacDonald

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
