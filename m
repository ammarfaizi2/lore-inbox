Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbRLaUBJ>; Mon, 31 Dec 2001 15:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287637AbRLaUA7>; Mon, 31 Dec 2001 15:00:59 -0500
Received: from ns.suse.de ([213.95.15.193]:17158 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287631AbRLaUAm>;
	Mon, 31 Dec 2001 15:00:42 -0500
Date: Mon, 31 Dec 2001 21:00:40 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: David Ford <david+cert@blue-labs.org>
Cc: Stewart Smith <stewart@softhome.net>, <timothy.covell@ashavan.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
In-Reply-To: <3C30BC16.6070809@blue-labs.org>
Message-ID: <Pine.LNX.4.33.0112312048160.17274-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, David Ford wrote:

> Starting a browser is equivalent to starting a mail client.  In some
> instances it's the same program.

keeping a terminal with ssh open all day is feasible (and is what I
and a lot of others probably do). Keeping mozilla open all day is
not practical. (and no, w3m/lynx etc are not practical for using
bugzilla imo).

> Hitting 2-3 keypresses to archive an email...how do you manage that
> archive v.s. it being managed for you w/ bugzilla?

both mua's I use have comprehensive indexing/searching abilities.
s25<enter> saves a patch for applying later.

cat ~/25 | patch -p1  is all I need to do, plus I have an archive
of patches applied on what date, along with the descriptive mails
that went with them.

Effortless.

If a patch needs reversing, I load the mua, move the mail to another
folder, and do the same with patch -R

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

