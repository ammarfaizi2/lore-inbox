Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWEEPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWEEPqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWEEPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:46:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751598AbWEEPqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:46:55 -0400
Date: Fri, 5 May 2006 11:46:38 -0400
From: Dave Jones <davej@redhat.com>
To: Martin Mares <mj@ucw.cz>
Cc: Pavel Machek <pavel@ucw.cz>, dtor_core@ameritech.net,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <20060505154638.GE22870@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Martin Mares <mj@ucw.cz>,
	Pavel Machek <pavel@ucw.cz>, dtor_core@ameritech.net,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz> <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com> <20060504183840.GE18962@redhat.com> <20060505103123.GB4206@elf.ucw.cz> <20060505152748.GA22870@redhat.com> <mj+md-20060505.153608.7268.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mj+md-20060505.153608.7268.albireo@ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 05:37:28PM +0200, Martin Mares wrote:
 > > On Fri, May 05, 2006 at 12:31:23PM +0200, Pavel Machek wrote:
 > > 
 > >  > If you only pressed single key -- your keyboard is crap or there's
 > >  > some problem in the driver.
 > >  > 
 > >  > If you never pressed any key -- your keyboard is crap or there's
 > >  > some problem in the driver.
 > > 
 > > That's hardly a constructive answer when the keyboard is a part of
 > > a laptop.  Crap hardware exists, get used to it.
 > 
 > Yes, but removing a message which can be sometimes useful is hardly
 > justified by crappy hardware sometimes triggering it. If it's triggered
 > too often, it should be rate-limited, not removed.

I'd argue that anything that triggers that many false positives is worthless.

		Dave

-- 
http://www.codemonkey.org.uk
