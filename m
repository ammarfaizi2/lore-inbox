Return-Path: <linux-kernel-owner+w=401wt.eu-S1161048AbWLPP3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWLPP3P (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWLPP3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:29:15 -0500
Received: from lazybastard.de ([212.112.238.170]:33564 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161048AbWLPP3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:29:15 -0500
Date: Sat, 16 Dec 2006 11:04:15 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061216110414.GA1862@lazybastard.org>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com> <Pine.LNX.4.64.0612131259260.5718@woody.osdl.org> <20061216090532.GF4049@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061216090532.GF4049@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 December 2006 09:05:32 +0000, Pavel Machek wrote:
> 
> Well.. it is easier to debug in userspace. While bad hw access can
> still kill the box, bad free() will not, and most bugs in early
> developent are actually of 2nd kind.

Isn't that what qemu is for?

Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
