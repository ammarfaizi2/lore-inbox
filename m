Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUBLQkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUBLQkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:40:11 -0500
Received: from [212.28.208.94] ([212.28.208.94]:18948 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266509AbUBLQkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:40:09 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: John Bradford <john@grabjohn.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Thu, 12 Feb 2004 17:40:03 +0100
User-Agent: KMail/1.6.1
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <200402121617.i1CGHH2c000275@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200402121617.i1CGHH2c000275@81-2-122-30.bradfords.org.uk>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402121740.03974.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 17.17, you wrote:
> Another thing to consider is that you can encode the same character in
> several ways using utf8, so two filenames could have different byte
> strings, but evaluate to the same set of unicode characters.

No. That's not UTF-8.

-- robin
