Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbTIDVzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbTIDVzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:55:35 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:8864 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S265530AbTIDVza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:55:30 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: precise characterization of ext3 atomicity
Date: Thu, 4 Sep 2003 23:59:11 +0200
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
References: <3F574A49.7040900@namesys.com> <200309042308.54002.phillips@arcor.de> <3F57B0FD.1060708@namesys.com>
In-Reply-To: <3F57B0FD.1060708@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042359.11754.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 23:39, Hans Reiser wrote:
> Daniel Phillips wrote:
> >I have always thought that some higher level synchronization is
> >required for simultaneous writes.  So Hans might as well tell his fans
> >that Ext3 makes no official guarantee, and neither does Linux.
>
> Not sure what you mean.

Nothing bad.  More power to you for adding a transaction interface to Reiser4, 
and blazing that trail.  It's totally missing as a generic api at the moment, 
and needs a push.

Regards,

Daniel

