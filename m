Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143870AbRA1TVz>; Sun, 28 Jan 2001 14:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143909AbRA1TVp>; Sun, 28 Jan 2001 14:21:45 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:58893 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S143870AbRA1TVh>; Sun, 28 Jan 2001 14:21:37 -0500
Date: Sun, 28 Jan 2001 14:26:38 -0500
From: Chris Mason <mason@suse.com>
To: James Lewis Nance <jlnance@intrex.net>, linux-kernel@vger.kernel.org
Subject: Re: Renaming lost+found
Message-ID: <9970000.980709998@tiny>
In-Reply-To: <20010126131949.A1041@bessie.dyndns.org>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, January 26, 2001 01:19:49 PM -0500 James Lewis Nance
<jlnance@intrex.net> wrote:

> FWIW IBM's JFS file system does not have a lost+found directory.  I dont
> remember if reiserfs does or not.
> 

reiserfsck creates it.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
