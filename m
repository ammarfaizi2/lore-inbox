Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUAHIl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 03:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUAHIl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 03:41:28 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:47804 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263793AbUAHIl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 03:41:28 -0500
Message-ID: <3FFD17B5.90603@comcast.net>
Date: Thu, 08 Jan 2004 02:41:25 -0600
From: Ian Pilcher <i.pilcher@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Checking patch for non-x86 bugs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that this is probably wishful thinking, but "they" always say
that the only stupid question is the one you don't ask.  (Whoever "they"
are, they are decidedly wrong about this, BTW.)

I have a patch that adds an x86-specific sysctl.  I believe that every-
thing is properly #ifdef'ed, but it would be awful nice to be able to
ensure that I haven't broken building on non-x86 architectures.  Is
there any way to do this without building a full-fledged cross-compiler
toolchain?  (And if not, does anyone know of a good HOWTO on setting up
such a toolchain?)

Thanks!
-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

