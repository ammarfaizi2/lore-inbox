Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280785AbRKSX5V>; Mon, 19 Nov 2001 18:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280786AbRKSX5N>; Mon, 19 Nov 2001 18:57:13 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15605
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280785AbRKSX5A>; Mon, 19 Nov 2001 18:57:00 -0500
Date: Mon, 19 Nov 2001 15:56:54 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Joel Beach <joelbeach@optushome.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maximum (efficient) partition sizes for various filesystem types...
Message-ID: <20011119155654.C11351@mikef-linux.matchmail.com>
Mail-Followup-To: Joel Beach <joelbeach@optushome.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E165lCN-00061N-00@the-village.bc.nu> <001401c170e4$1d890d20$1e50a8c0@kinslayer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401c170e4$1d890d20$1e50a8c0@kinslayer>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 09:22:38PM +1100, Joel Beach wrote:
> I think I'll fix up that bit in the Debian manual myself then if they let
> me....
> 
> For what it's worth, here's the paragraph from the "Woody" installation
> manual:
> 
> "For new users, personal Debian boxes, home systems, and other single-user
> setups, a single / partition (plus swap) is probably the easiest, simplest
> way to go. It is possible to have problems with this idea, though, with
> larger (20GB) disks. Based on limitations in how ext2 works, avoid any
> single partition greater than 6GB or so."
> 

No.  They mean limitations of relatively old IDE hardware...
