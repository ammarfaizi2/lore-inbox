Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTJAOWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTJAOWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:22:30 -0400
Received: from ns.suse.de ([195.135.220.2]:16551 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262253AbTJAOWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:22:24 -0400
To: root@chaos.analogic.com
Cc: Jurjen Oskam <jurjen@stupendous.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
References: <1065012013.4078.2.camel@lisaserver>
	<20031001135322.GA16692@quadpro.stupendous.org>
	<Pine.LNX.4.53.0310011004570.3612@chaos>
From: Andreas Schwab <schwab@suse.de>
X-Yow: GOOD-NIGHT, everybody..  Now I have to go administer FIRST-AID
 to my pet LEISURE SUIT!!
Date: Wed, 01 Oct 2003 16:22:15 +0200
In-Reply-To: <Pine.LNX.4.53.0310011004570.3612@chaos> (Richard B. Johnson's
 message of "Wed, 1 Oct 2003 10:09:51 -0400 (EDT)")
Message-ID: <jer81x82co.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> ...So anything you put into "/tmp", for instance, can be deleted
> by anybody. This is the Unix way.

...Unless your /tmp is marked properly with +t (sticky bit), so that you
can only delete your own files.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
