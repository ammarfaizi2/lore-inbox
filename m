Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261925AbSIZApH>; Wed, 25 Sep 2002 20:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSIZApH>; Wed, 25 Sep 2002 20:45:07 -0400
Received: from vitelus.com ([64.81.243.207]:52998 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261925AbSIZApG>;
	Wed, 25 Sep 2002 20:45:06 -0400
Date: Wed, 25 Sep 2002 17:50:20 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926005020.GA4587@vitelus.com>
References: <E17uINs-0003bG-00@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17uINs-0003bG-00@think.thunk.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 04:03:44PM -0400, tytso@mit.edu wrote:
> In order to use the new directory indexing feature, please update your
> e2fsprogs to 1.29.  Existing filesystem can be updated to use directory
> indexing using the command "tune2fs -O dir_index /dev/hdXXX".

Do new filesystems created with e2fsprogs 1.29 use this feature by
default?
