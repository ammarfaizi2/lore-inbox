Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268211AbUGXBDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268211AbUGXBDB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 21:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUGXBDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 21:03:01 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:32937 "EHLO
	mailfe04.swip.net") by vger.kernel.org with ESMTP id S268211AbUGXBDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 21:03:00 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sat, 24 Jul 2004 03:02:57 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Mario Lang <mlang@delysid.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User-space Keyboard input?
Message-ID: <20040724010256.GA3757@bouh.is-a-geek.org>
Mail-Followup-To: Mario Lang <mlang@delysid.org>,
	linux-kernel@vger.kernel.org
References: <87y8lb80yj.fsf@lexx.delysid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8lb80yj.fsf@lexx.delysid.org>
User-Agent: Mutt/1.4.1i-nntp3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

About modifiers, I submitted a patch to Dave to handle them
properly.

But ascii to scancode translation still depends on scancode to ascii
translation performed by the kernel indeed and the question still
applies. I'll have a look at uinput.

Regards,
Samuel
