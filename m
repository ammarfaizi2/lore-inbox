Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbTLGDdf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 22:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTLGDdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 22:33:31 -0500
Received: from holomorphy.com ([199.26.172.102]:53975 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265296AbTLGDda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 22:33:30 -0500
Date: Sat, 6 Dec 2003 19:31:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
Message-ID: <20031207033106.GN19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Wakko Warner <wakko@animx.eu.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org> <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org> <20031206191650.A4199@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206191650.A4199@animx.eu.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Linus wrote:
>> And you liked the fact that you were supposed to write "dev=0,0,0" or
>> something strange like that? What a piece of crap it was.

On Sat, Dec 06, 2003 at 07:16:50PM -0500, Wakko Warner wrote:
> I have it named using cdrecord's defaults.  People who have real scsi
> burners still have to use that format.

Since I appear to be one of the very few who have a SCSI burner around,
I might as well chime in. ISTR being able to use dev=/dev/scd0 at some
point, though axboe might know more (I'm pretty much at an end-user
level on these kinds issues for the moment).


-- wli
