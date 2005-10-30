Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVJ3Lj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVJ3Lj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 06:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVJ3Lj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 06:39:59 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:44208 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932075AbVJ3Lj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 06:39:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 4/6] swsusp: move swap check out of swsusp_suspend
Date: Sun, 30 Oct 2005 13:40:20 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
References: <200510292158.11089.rjw@sisk.pl> <200510292236.47960.rjw@sisk.pl> <20051029232134.GG14209@elf.ucw.cz>
In-Reply-To: <20051029232134.GG14209@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301340.20959.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 30 of October 2005 01:21, Pavel Machek wrote:
> Hi!
> 
> > This is a non-essential step making the next patch possible.  No functionality
> > changes.
> 
> If you can push this before 3/6, that would be nice.

Sure.  I think I'll send the two patches you have already acked and this one
to Andrew as a separate series.  Then I'll get back to the 3/6 etc.

Greetings,
Rafael
