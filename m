Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbTI1KUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTI1KUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:20:54 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:47057 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S262405AbTI1KUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:20:54 -0400
Date: Sun, 28 Sep 2003 12:20:53 +0200
From: Ookhoi <ookhoi@humilis.net>
To: Stef van der Made <svdmade@planet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Onstream DI-30 locks up PC when in use
Message-ID: <20030928102053.GA7863@favonius>
Reply-To: ookhoi@humilis.net
References: <1064678738.3578.8.camel@sunshine> <Pine.LNX.4.56.0309271950450.21678@localhost.localdomain> <1064693831.1792.9.camel@sunshine> <3F75F1ED.9010307@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F75F1ED.9010307@planet.nl>
X-Uptime: 12:53:05 up 110 days, 11:25, 33 users,  load average: 1.87, 1.49, 1.20
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stef van der Made wrote (ao):
> I'm trying to get my DI-30 Onstream tapedrive to work. Some pacthes were 
> put inot linux 2.6-test5. When I bootup it recognizes the drive :-))) 
> but when I try to use the drive it locks up my PC immediatly.
> 
> I've updated the bug on bugzilla 
> "http://bugzilla.kernel.org/show_bug.cgi?id=967"
> 
> but got no reply yet. Are there more people trying to get this drive to 
> work and if yes what are your experiences with this drive and 2.6 test5

It doesn't work yet in 2.6 due to broken ide-scsi support.
