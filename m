Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUH0Uy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUH0Uy1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUH0UxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:53:22 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:52731 "EHLO
	mailrelay01.tugraz.at") by vger.kernel.org with ESMTP
	id S267659AbUH0Uu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:50:29 -0400
From: Christian Mayrhuber <christian.mayrhuber@gmx.net>
To: reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Date: Fri, 27 Aug 2004 22:56:07 +0200
User-Agent: KMail/1.7
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0408271010300.10272-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0408271010300.10272-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408272256.07619.christian.mayrhuber@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 16:12, Rik van Riel wrote:

> Because not everybody uses tar.  Quite a few people use a
> network backup system, while others use duplicity, RPM uses
> cpio internally and big companies tend to use proprietary
> network backup suites.
Big backup systems support scripts that can be run prior to
backup and post restore. You aready have to use star to
do a metadata backup the acl's/ea into some tgz, which
can be unpacked after restore.

> Breaking people's setup is something to worry about.
Yeah, maybe. But as usual on UN*X  like systems most admins
are able to come up with a quick shell/perl script to solve their
particular problem.

-- 
lg, Chris
