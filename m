Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTJJKvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTJJKvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:51:41 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:27321 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262038AbTJJKvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:51:39 -0400
X-Sender-Authentication: net64
Date: Fri, 10 Oct 2003 12:51:37 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: lgb@lgb.hu, Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-Id: <20031010125137.4080a13b.skraw@ithnet.com>
In-Reply-To: <3F864F82.4050509@longlandclan.hopto.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
	<20031009115809.GE8370@vega.digitel2002.hu>
	<20031009165723.43ae9cb5.skraw@ithnet.com>
	<3F864F82.4050509@longlandclan.hopto.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 16:19:46 +1000
Stuart Longland <stuartl@longlandclan.hopto.org> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephan von Krawczynski wrote:
> > * hotplug CPU
> > * hotplug RAM
> 
> * hotplug motherboard & entire computer too I spose ;-)
> 
> Although sarcasm aside, a couple of ideas that have been bantered around 
> on this list (and a few of my own ideas):

You are obviously not quite familiar with industrial boxes where this is
state-of-the-art. 

My thinking is:
* CPU hotplug: should not be too hard
* RAM hotplug: has already been discussed in several threads, sure needs brain,
but must be doable.

Generally spoken every part of a computer should be thought of as a "resource"
that can be added or removed at any time during runtime. CPU or RAM is in no
way different.

Regards,
Stephan

