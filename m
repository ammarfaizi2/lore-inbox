Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUBIM0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUBIM0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:26:07 -0500
Received: from main.gmane.org ([80.91.224.249]:37277 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265059AbUBIM0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:26:05 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Date: Mon, 09 Feb 2004 13:26:02 +0100
Message-ID: <yw1x65ego2w5.fsf@kth.se>
References: <20040209115852.GB877@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:lj9R4Cye4tZkYUa43IUw0P7A3aE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> writes:

> Morning!
>
> What Linux supported filesystems support UTF-8 filenames?

AFAIK, the filesystems don't care what you put in the filenames.  They
just treat is as a sequence of bytes.

> Looks like at least xfs and reiserfs are not able of handling them,
> as Apache with UTF-8 as default charset delievers wrong names, when
> accessing files with German umlauts.

Wrong in what way?  How did you create the filenames?

-- 
Måns Rullgård
mru@kth.se

