Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTBJHVy>; Mon, 10 Feb 2003 02:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbTBJHVy>; Mon, 10 Feb 2003 02:21:54 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:34311 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263760AbTBJHVw>; Mon, 10 Feb 2003 02:21:52 -0500
Date: Mon, 10 Feb 2003 07:31:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030210073137.C15814@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Wagner <daw@mozart.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <20030206151820.A11019@infradead.org> <Pine.LNX.3.96.1030207205056.31221A-100000@dixie> <20030209200626.A7704@infradead.org> <b27f3n$bbj$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b27f3n$bbj$1@abraham.cs.berkeley.edu>; from daw@mozart.cs.berkeley.edu on Mon, Feb 10, 2003 at 05:59:19AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 05:59:19AM +0000, David Wagner wrote:
> Christoph Hellwig  wrote:
> >[...] given that selinux is the only module actually using it [...]
> 
> No, it's not.  I keep you telling you LSM is not just about SELinux,
> but I'm happy to say it again, if necessary.

So show me a different module using most of the hooks, it's that simple!

