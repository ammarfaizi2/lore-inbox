Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRJKNBp>; Thu, 11 Oct 2001 09:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276309AbRJKNBg>; Thu, 11 Oct 2001 09:01:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21391 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276255AbRJKNBX>;
	Thu, 11 Oct 2001 09:01:23 -0400
Date: Thu, 11 Oct 2001 09:01:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Vincent Sweeney <v.sweeney@dexterus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Lost Partition
In-Reply-To: <3BC58D32.F500422@dexterus.com>
Message-ID: <Pine.GSO.4.21.0110110858550.22698-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Vincent Sweeney wrote:

> Disk /dev/hdb: 255 heads, 63 sectors, 1240 cylinders
> Units = cylinders of 16065 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hdb1   *         1        66    530113+  82  Linux swap
> /dev/hdb2            67      1240   9430155    5  Extended
> /dev/hdb5            67      1240   9430123+  83  Linux

How about the contents of sectors 0 and 1076355?

