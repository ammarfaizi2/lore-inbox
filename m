Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTDXXzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbTDXXy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:54:28 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:50904 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264525AbTDXXxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:53:46 -0400
Message-ID: <3EA87BE1.1070107@suwalski.net>
Date: Thu, 24 Apr 2003 20:05:53 -0400
From: Pat Suwalski <pat@suwalski.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030331
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
Cc: Jamie Lokier <jamie@shareable.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
References: <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424213632.GK30082@mail.jlokier.co.uk> <20030424205515.T3557@almesberger.net>
In-Reply-To: <20030424205515.T3557@almesberger.net>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Or, to phrase this as a question, how likely is it that somebody
> will prefer OSS over ALSA ? (E.g. because there is no ALSA driver,
> the ALSA driver doesn't work, some application doesn't work with
> ALSA, etc.)

For that, refer to my other bug: 
http://bugzilla.kernel.org/show_bug.cgi?id=622

During window-switching activities in X, ALSA sound is interrupted. It 
is quite annoying. For this reason, I have actually gone back to using a 
2.4 kernel with OSS, though I hear my problem would not exist if I use 
deprecated OSS in 2.5.x.

This is on a fairly popular AC97 i810 chipset.

--Pat

