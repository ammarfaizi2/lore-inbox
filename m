Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbVKAX4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbVKAX4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbVKAXzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:55:54 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:55744 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751456AbVKAXzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:55:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] swsusp: simplify pagedir relocation
Date: Wed, 2 Nov 2005 00:15:34 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510301637.48842.rjw@sisk.pl> <200511011837.10386.rjw@sisk.pl> <20051101211135.GJ7172@elf.ucw.cz>
In-Reply-To: <20051101211135.GJ7172@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020015.34523.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 1 of November 2005 22:11, Pavel Machek wrote:
> 
> > The appended patch simplifies the relocation of the page backup list
> > (aka pagedir) during resume.
> 
> ACK and thanks for patience.

No big deal.

Greetings,
Rafael
