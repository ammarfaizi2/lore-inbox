Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVI1RUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVI1RUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbVI1RUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:20:41 -0400
Received: from quechua.inka.de ([193.197.184.2]:47539 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751436AbVI1RUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:20:40 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: linux-kernel@vger.kernel.org
Subject: fat / multi arch binaries?
Date: Wed, 28 Sep 2005 19:18:56 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281918.56386.aj@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

does linux support binaries with code
for several architectures? I read that
elf allowes that, and for example
apple plans to use it on mac os X,
but I couldn't find anything whether
such binaries would work with linux
or not. can you tell me?

if linux supports that, it should
also work for merging x86 and x86_64
into one binary? would ther be a way
to run the 32bit version in the 64bit
kernel, if requested? are there any
tools to create such binaries?

with google I found info from 97
that indicades elf format has no
provision for fat binaries and linux
doesn't support them. is that still
true?

Thanks, Andreas
