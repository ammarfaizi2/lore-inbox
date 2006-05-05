Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWEEQAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWEEQAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWEEQAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:00:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50824 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751524AbWEEQAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:00:18 -0400
Date: Fri, 5 May 2006 12:00:09 -0400
From: Dave Jones <davej@redhat.com>
To: Martin Mares <mj@ucw.cz>
Cc: Pavel Machek <pavel@ucw.cz>, dtor_core@ameritech.net,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <20060505160009.GB25883@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Martin Mares <mj@ucw.cz>,
	Pavel Machek <pavel@ucw.cz>, dtor_core@ameritech.net,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz> <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com> <20060504183840.GE18962@redhat.com> <20060505103123.GB4206@elf.ucw.cz> <20060505152748.GA22870@redhat.com> <mj+md-20060505.153608.7268.albireo@ucw.cz> <20060505154638.GE22870@redhat.com> <mj+md-20060505.154834.7444.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mj+md-20060505.154834.7444.albireo@ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 05:54:52PM +0200, Martin Mares wrote:
 > > I'd argue that anything that triggers that many false positives is worthless.
 >
 > Why do you think these are false positives? They usually report real
 > problems.

Did you read my earlier posts?
Users are seeing this *during boot*, before they've even pressed *ANY* keys.
They're seeing it after pressing a *single* key.

How on earth is "too many keys pressed" a useful message in this context?
Yes, maybe their keyboard is crap, but what is the user to do?
Go buy a new laptop because someone else has a utopian view on how hardware should be?

 > Unfortunately a significant fraction of keyboards is crappy
 > these days, but it's still good to know if the keyboard you are currently
 > testing is broken or not.

When a user can't do *anything* about it, it's useless, and serves
as nothing but a cause for concern. "Oh no, is my laptop dying?".

		Dave

-- 
http://www.codemonkey.org.uk
