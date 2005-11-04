Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVKDQ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVKDQ12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVKDQ11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:27:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31421 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932130AbVKDQ11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:27:27 -0500
Date: Fri, 4 Nov 2005 16:27:26 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: jblunck@suse.de
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
Message-ID: <20051104162726.GJ7992@ftp.linux.org.uk>
References: <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de> <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu> <20051104151104.GA22322@hasse.suse.de> <E1EY3Y8-0004XX-00@dorka.pomaz.szeredi.hu> <20051104154610.GB23962@hasse.suse.de> <E1EY3uI-0004cC-00@dorka.pomaz.szeredi.hu> <20051104160443.GB25491@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104160443.GB25491@hasse.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 05:04:43PM +0100, jblunck@suse.de wrote:
> This is a bug and it should get fixed.

So fix your libc...
