Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbRAOTzM>; Mon, 15 Jan 2001 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbRAOTzC>; Mon, 15 Jan 2001 14:55:02 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:45830 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129994AbRAOTy4>; Mon, 15 Jan 2001 14:54:56 -0500
Date: Mon, 15 Jan 2001 14:57:42 -0500
From: Chris Mason <mason@suse.com>
To: hugang <linuxhappy@etang.com>, linux-kernel@vger.kernel.org
Subject: Re: patch:reiserfs 3.6.25 + LVM(Fix oops reiserfs filesystem)
Message-ID: <153220000.979588662@tiny>
In-Reply-To: <20010113234151.1d6e872e.linuxhappy@etang.com>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, January 13, 2001 11:41:51 PM -0800 hugang
<linuxhappy@etang.com> wrote:

[ patch ]

Odd, the create_vi op should never be null, so the real fix is somewhere
else.  We'll look into this.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
