Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289335AbSAVSHt>; Tue, 22 Jan 2002 13:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289336AbSAVSHc>; Tue, 22 Jan 2002 13:07:32 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:10389 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289335AbSAVSHT>;
	Tue, 22 Jan 2002 13:07:19 -0500
Date: Tue, 22 Jan 2002 13:07:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Michael Zhu <mylinuxk@yahoo.ca>
cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: metadata and contents in loop device
In-Reply-To: <20020122180201.42898.qmail@web14905.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0201221306580.14029-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Jan 2002, Michael Zhu wrote:

> Hello, everyone, in my loop device I want to use
> different keys to en/decrypt the file contents and the
> metadata of directories/file names information. But
> how can I differentiate these two types of data in the
> loop device?

You can't.

