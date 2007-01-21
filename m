Return-Path: <linux-kernel-owner+w=401wt.eu-S1751419AbXAUTfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbXAUTfu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXAUTfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:35:50 -0500
Received: from thunk.org ([69.25.196.29]:43656 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbXAUTft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:35:49 -0500
Date: Sun, 21 Jan 2007 14:30:09 -0500
From: Theodore Tso <tytso@mit.edu>
To: Grzegorz =?utf-8?Q?Ja=C5=9Bkiewicz?= <gryzman@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Johannes Stezenbach <js@linuxtv.org>,
       Joe Barr <joe@pjprimer.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial port blues
Message-ID: <20070121193009.GF27422@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Grzegorz =?utf-8?Q?Ja=C5=9Bkiewicz?= <gryzman@gmail.com>,
	Willy Tarreau <w@1wt.eu>, Johannes Stezenbach <js@linuxtv.org>,
	Joe Barr <joe@pjprimer.com>,
	Linux Kernel mailing List <linux-kernel@vger.kernel.org>
References: <1169242654.20402.154.camel@warthawg-desktop> <20070120173644.GY24090@1wt.eu> <20070121055456.GC27422@thunk.org> <20070121070557.GB31780@1wt.eu> <20070121140421.GA13425@linuxtv.org> <2f4958ff0701210650w4fa0138di6a5026de8a0823dc@mail.gmail.com> <20070121145817.GE31780@1wt.eu> <2f4958ff0701210710r743c1821n9af23a050c847a7@mail.gmail.com> <20070121185218.GD27422@thunk.org> <2f4958ff0701211105p4f7e3e86x8aaf14566112bc51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4958ff0701211105p4f7e3e86x8aaf14566112bc51@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 08:05:52PM +0100, Grzegorz Jaśkiewicz wrote:
>
> But on the other hand, PC nowadays are capable of handling RT tasks +
> running multiple programs in background, but OS has to be build from ground
> up to handle such conditions (I guess most RTOSes are justa about that, but
> I never had a chance/need to use one - I tend to use loads of AVRs just for
> those small tasks).

Check out http://rt.wiki.kernel.org

						- Ted
