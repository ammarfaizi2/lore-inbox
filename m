Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUJZUSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUJZUSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUJZUQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:16:56 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:50033 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261403AbUJZUQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:16:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=V0hfZ+5+jRPuVaY5rppRkwzaRSLGXPUGV7t2RX98gDkX7G0i4tGx9Ws+cz2LH4fIO3TLpzQiOrxGMqCPXTAcedvTCpyD3F6STo3pu6L5GJ7E8+hmjow+oD8wgZmLbkrpXURdHDLwGHNZmeTEDcs4vo8B8bexzfx47It9lEW43WY=
Message-ID: <4d8e3fd304102613165b2fb283@mail.gmail.com>
Date: Tue, 26 Oct 2004 22:16:08 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk
Subject: Let's make a small change to the process
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <877jpdcnf5.fsf@barad-dur.crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410260644.47307.edt@aei.ca>
	 <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
	 <4d8e3fd3041026050823d012dc@mail.gmail.com>
	 <877jpdcnf5.fsf@barad-dur.crans.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
despite I know you are all bored with the " I know how to improve the
process" email but I want to share with you this idea .-)

Both Andrew and Linus are doing an impressive job so I really don't
think we need to change the way they are working.

What I'm suggesting is start offering 2.6.X:Y kernel, you did for 2.6.8.1 so...

The .Y patchset contains only important security fix (all stuff you
think are important) and is weekly uploaded to kernel.org

Doing that, people:
-  can stop running "personal version of vanilla kernel
-  don't need to wait till next Linus' release in order to have a
security bug fixed

We, of course, need a maintainer for it,
maybe someone from OSDL (Randy?), maybe wli (he maintained his tree
for a long time), maybe Alan (that is already applying these kind of
fixes to his tree), maybe someone else... ?

Sounds reasonable ?

-- 
Paolo
