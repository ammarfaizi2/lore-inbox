Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266913AbUBMK33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266918AbUBMK33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:29:29 -0500
Received: from [212.28.208.94] ([212.28.208.94]:61446 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266913AbUBMK32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:29:28 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 11:29:26 +0100
User-Agent: KMail/1.6.1
Cc: viro@parcelfarce.linux.theplanet.co.uk, Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <200402131103.10366.robin.rosenberg.lists@dewire.com> <200402131222.17656.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200402131222.17656.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402131129.26878.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 11.22, vda wrote:
> Al says that there can be a hundred of users on the box _simultaneously_,
> each with different locale. fs should store filenames
> in locale-agnostic way.

I assume we agree then :-)

-- robin
