Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262801AbSJLD5a>; Fri, 11 Oct 2002 23:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbSJLD5a>; Fri, 11 Oct 2002 23:57:30 -0400
Received: from holomorphy.com ([66.224.33.161]:56451 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262801AbSJLD53>;
	Fri, 11 Oct 2002 23:57:29 -0400
Date: Fri, 11 Oct 2002 20:59:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
Message-ID: <20021012035958.GD10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	Dave Hansen <haveblue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3DA798B6.9070400@us.ibm.com> <20021012035141.GC7050@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012035141.GC7050@krispykreme>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 01:51:41PM +1000, Anton Blanchard wrote:
> Id like to oblige but I hear the list has a 100kB limit :)
> Anton

Bah! I'm at a competitive disadvantage because I've got a lesser
BITS_PER_LONG. No matter, NR_CPUS > BITS_PER_LONG shall be conquered
and the explosion of kernel threads will be quite visible (though
unfortunately probably post-freeze).



Cheers,
Bill
