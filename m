Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTIDUM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbTIDUM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:12:26 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:34469 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S264902AbTIDUMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:12:24 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>
Subject: Re: precise characterization of ext3 atomicity
Date: Thu, 4 Sep 2003 22:16:04 +0200
User-Agent: KMail/1.5.3
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org>
In-Reply-To: <20030904085537.78c251b3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042216.04121.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 17:55, Andrew Morton wrote:
> Hans Reiser <reiser@namesys.com> wrote:
> > Is it correct to say of ext3 that it guarantees and only guarantees
> > atomicity of writes that do not cross page boundaries?
>
> Yes.

Is that just happenstance, or does Posix or similar mandate it?

Regards,

Daniel

