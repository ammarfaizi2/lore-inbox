Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVBJQnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVBJQnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 11:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVBJQnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 11:43:39 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:260 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262172AbVBJQni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 11:43:38 -0500
Date: Thu, 10 Feb 2005 17:43:28 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: Irix NFS server usual problem [patch, fc3 2.6.10-1,760_FC3]
Message-ID: <20050210164328.GA5267@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	"Hack inc." <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
References: <20050207221638.GA18723@dspnet.fr.eu.org> <1107816524.9970.8.camel@lade.trondhjem.org> <20050210124832.GA23320@dspnet.fr.eu.org> <1108048844.9840.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108048844.9840.55.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 10:20:44AM -0500, Trond Myklebust wrote:
> A permanent fix probably ought to involve removing our current
> dependency on using the server-generated readdir cookies as
> telldir/seekdir offsets.

Remplacing it by?  As in, I'm ready to do and test the code if I have
a decent idea of what would be acceptable.

  OG.
