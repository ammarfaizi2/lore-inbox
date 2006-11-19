Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755490AbWKSBrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbWKSBrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 20:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbWKSBrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 20:47:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2227 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1755490AbWKSBrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 20:47:17 -0500
Date: Sun, 19 Nov 2006 02:46:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 4/4] swsusp: Fix labels
Message-ID: <20061119014658.GA15897@elf.ucw.cz>
References: <200611182335.27453.rjw@sisk.pl> <200611182351.01924.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611182351.01924.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-11-18 23:51:01, Rafael J. Wysocki wrote:
> Move all labels in the swsusp code to the second column, so that they won't
> fool diff -p.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
