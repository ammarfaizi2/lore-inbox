Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUBMDlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUBMDlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:41:31 -0500
Received: from mail.shareable.org ([81.29.64.88]:31618 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266721AbUBMDla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:41:30 -0500
Date: Fri, 13 Feb 2004 03:41:19 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Robert White <rwhite@casabyte.com>
Cc: "'Theodore Ts'o'" <tytso@mit.edu>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'the grugq'" <grugq@hcunix.net>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040213034119.GK25499@mail.shareable.org>
References: <20040204062936.GA2663@thunk.org> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAiYFsPtMTN0OBYHMfkO9ONQEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAiYFsPtMTN0OBYHMfkO9ONQEAAAAA@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert White wrote:
> On the more positive side this would be _*outstanding*_ for my NV-RAM
> keychain drive where the files are warranted to be small and I don't want
> some random person who finds my lost keychain even able to guess about that
> pesky project I was working on last month.

An encrypted and/or steganographic filesystem would be much better for
your NVRAM keychain drive, because that hides your files even when you
_haven't_ deleted them.

-- Jamie
