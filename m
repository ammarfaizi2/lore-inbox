Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbUJZUjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUJZUjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUJZUiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:38:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60855 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261464AbUJZUhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:37:05 -0400
Date: Tue, 26 Oct 2004 16:36:44 -0400
From: Dave Jones <davej@redhat.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Let's make a small change to the process
Message-ID: <20041026203644.GD2307@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200410260644.47307.edt@aei.ca> <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin> <4d8e3fd3041026050823d012dc@mail.gmail.com> <877jpdcnf5.fsf@barad-dur.crans.org> <4d8e3fd304102613165b2fb283@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd304102613165b2fb283@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 10:16:08PM +0200, Paolo Ciarrocchi wrote:
 
 > The .Y patchset contains only important security fix (all stuff you
 > think are important) and is weekly uploaded to kernel.org
 > 
 > Doing that, people:
 > -  can stop running "personal version of vanilla kernel
 > -  don't need to wait till next Linus' release in order to have a
 > security bug fixed
 > 
 > We, of course, need a maintainer for it,
 > maybe someone from OSDL (Randy?), maybe wli (he maintained his tree
 > for a long time), maybe Alan (that is already applying these kind of
 > fixes to his tree), maybe someone else... ?

2.6-ac seems to be filling this role right now.

		Dave

