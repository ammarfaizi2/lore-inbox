Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbTFLIGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 04:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbTFLIGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 04:06:36 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:37504 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264221AbTFLIGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 04:06:36 -0400
Date: Thu, 12 Jun 2003 09:27:28 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306120827.h5C8RSEV000896@81-2-122-30.bradfords.org.uk>
To: davej@codemonkey.org.uk, skuld@anime.net
Subject: Re: Via KT400 and AGP 8x Support
Cc: gregor.essers@web.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only other solution is to kick your card down into AGP 2.0 mode, which
> most BIOSes do not allow you to do in software. Instead what you have to
> do is cut/unsolder traces on your video card for the pins used for AGP 3.0
> detection. This is a near-permanent and horrible solution but it does get
> everything working. :-/

Insulating tape on certain pins works on ISA cards, but whether it would be
practical on the smaller pins of an AGP card, I'm not sure.

John.
