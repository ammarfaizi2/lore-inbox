Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRCPRi7>; Fri, 16 Mar 2001 12:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130723AbRCPRit>; Fri, 16 Mar 2001 12:38:49 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:51268 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S130673AbRCPRib>;
	Fri, 16 Mar 2001 12:38:31 -0500
Message-ID: <20010316183750.A11156@win.tue.nl>
Date: Fri, 16 Mar 2001 18:37:50 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Art Boulatov <art@ksu.ru>, linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: union mounts WAS: pivot_root & linuxrc problem
In-Reply-To: <Pine.LNX.4.33.0103160822350.1057-100000@mikeg.weiden.de> <3AB21DB5.7030105@ksu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3AB21DB5.7030105@ksu.ru>; from Art Boulatov on Fri, Mar 16, 2001 at 05:05:41PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2001 at 05:05:41PM +0300, Art Boulatov wrote:

> I've seen new options for "mount" like --bind, --over, but didn't really 
> get how they work or are they implemented at all.

"mount --bind" works on vanilla 2.4. The others don't.
