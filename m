Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTCJVgA>; Mon, 10 Mar 2003 16:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbTCJVf7>; Mon, 10 Mar 2003 16:35:59 -0500
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:1005 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP
	id <S261486AbTCJVf4>; Mon, 10 Mar 2003 16:35:56 -0500
Subject: Re: [Ext2-devel] Re: [RFC] Improved inode number allocation for
	HTree
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: John Bradford <john@grabjohn.com>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, tytso@mit.edu, adilger@clusterfs.com,
       chrisl@vmware.com, bzzz@tmi.comex.ru
In-Reply-To: <20030310212953.57F2310435B@mx12.arcor-online.net>
References: <200303102104.h2AL43iZ000875@81-2-122-30.bradfords.org.uk>
	 <20030310212953.57F2310435B@mx12.arcor-online.net>
Content-Type: text/plain
Organization: 
Message-Id: <1047332834.11339.3.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Mar 2003 13:47:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 13:33, Daniel Phillips wrote:

> It sounds practical.  Why stop there?

Why start?  Who actually uses atime for anything at all, other than the
tiny number of shops that care about moving untouched files to tertiary
storage?

Surely if you want to heap someone else's plate with work, you should
offer a reason why :-)

	<b

