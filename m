Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSJ1RAP>; Mon, 28 Oct 2002 12:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbSJ1RAP>; Mon, 28 Oct 2002 12:00:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28946 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261376AbSJ1RAN>;
	Mon, 28 Oct 2002 12:00:13 -0500
Date: Mon, 28 Oct 2002 17:06:33 +0000
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk,
       hugh@veritas.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
Message-ID: <20021028170633.R27461@parcelfarce.linux.theplanet.co.uk>
References: <20021028143226.N27461@parcelfarce.linux.theplanet.co.uk> <20021028.062608.78045801.davem@redhat.com> <20021028163649.P27461@parcelfarce.linux.theplanet.co.uk> <20021028.085536.32752918.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028.085536.32752918.davem@redhat.com>; from davem@redhat.com on Mon, Oct 28, 2002 at 08:55:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 08:55:36AM -0800, David S. Miller wrote:
> Need to go into the revision history, discover who added these
> calls, and ask them why they were added.

They're in 2.2.20, if it helps...

-- 
Revolutions do not require corporate support.
