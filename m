Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265166AbSJaEX3>; Wed, 30 Oct 2002 23:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265176AbSJaEX3>; Wed, 30 Oct 2002 23:23:29 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:32529 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265166AbSJaEX2>; Wed, 30 Oct 2002 23:23:28 -0500
Date: Wed, 30 Oct 2002 23:31:29 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
In-Reply-To: <20021031042548.A23326@infradead.org>
Message-ID: <Pine.LNX.4.44.0210302330210.8463-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Christoph Hellwig wrote:

> On Wed, Oct 30, 2002 at 11:20:42PM -0500, Patrick Finnegan wrote:
> > Specifically, the interoperation with IBM's JFS LVM and MS's LVM will be
>
> JFS has no lvm, it just sits on any blockdevice.  The support for Windows
> dynamic disks actually layers ontop of the MD driver..

To be more specific, I'm talking about AIX's JFS, not linux's JFS...

--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif



