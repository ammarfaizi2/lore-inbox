Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315206AbSEYSSI>; Sat, 25 May 2002 14:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSEYSSH>; Sat, 25 May 2002 14:18:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34486 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315206AbSEYSSG>;
	Sat, 25 May 2002 14:18:06 -0400
Date: Sat, 25 May 2002 14:18:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: John Weber <john.weber@linuxhq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: HFS Compile Problem
In-Reply-To: <3CEFD385.5060001@linuxhq.com>
Message-ID: <Pine.GSO.4.21.0205251417480.13379-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, John Weber wrote:

> [1] HFS Compile Error

add include <linux/pagemap.h>

