Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTETF7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 01:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTETF7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 01:59:42 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:8945 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263579AbTETF7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 01:59:41 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030519225602.GH8978@holomorphy.com>
References: <1053289316.10127.41.camel@nosferatu.lan>
	 <20030519063813.A30004@infradead.org>
	 <1053341023.9152.64.camel@workshop.saharact.lan>
	 <20030519105152.GD8978@holomorphy.com> <babheo$s9r$1@cesium.transmeta.com>
	 <20030519224414.GG8978@holomorphy.com> <3EC95EA9.9060504@zytor.com>
	 <20030519225602.GH8978@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053410793.9142.125.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 20 May 2003 08:06:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, May 19, 2003 at 03:46:01PM -0700, H. Peter Anvin wrote:
> > Unfortunately "the current policy" is unrealistic, and repeating it
> > doesn't make it any less so.
> 
> No contest there; unfortunately unrealistic amounts of work seem to
> be required to get around the general state of affairs at times. =(
> Does it really have to be 2.7? It seems most of this would be header
> reorganization with no runtime impact on the kernel.
> 

Well, this is a tender issue - both for users and non kernel developers
working on a project that may (according to the author at least *g*)
need kernel headers.

Getting something done sooner than later would thus be appreciated from
many venues, and will also get rid of your head aces =)

Trying to get back to my point ... I am sure there are many people
that will help getting this done, if only somebody with enough knowledge
of how the kernel devs want the ABI headers to look like will take some
kind of lead in the effort - i2c and sensor support in 2.5 is a good
example.


Regards,

-- 
Martin Schlemmer


