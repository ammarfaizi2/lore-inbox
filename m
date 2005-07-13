Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVGMV5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVGMV5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVGMVyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:54:55 -0400
Received: from siaag1aa.compuserve.com ([149.174.40.3]:9866 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262652AbVGMVd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:33:29 -0400
Date: Wed, 13 Jul 2005 17:29:32 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.13-rc2-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200507131733_MC3-1-A464-F432@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005 at 00:23:42 -0700, Andrew Morton wrote:

>>    ...and BTW why does every line in the series file have a trailing space?
>
> Not in my copy of
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm2/patch-series
> ?


  Looks like Quilt is adding the space during push/pop operations.  Only the
lines it has touched in the series file have the trailing space.


--
Chuck
