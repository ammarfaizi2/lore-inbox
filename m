Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265072AbTGBP4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbTGBP4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:56:18 -0400
Received: from smtp0.libero.it ([193.70.192.33]:23802 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S265072AbTGBP4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:56:18 -0400
Subject: Re: 2.4.21 cd-writer problem
From: Flameeyes <daps_mls@libero.it>
To: =?ISO-8859-1?Q?C=E9dric?= <cedriccsm2@ifrance.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3F02FA3E.2080004@ifrance.com>
References: <200307012029.h61KTUZk001416@81-2-122-30.bradfords.org.uk>
	 <3F02FA3E.2080004@ifrance.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1057162265.9026.3.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 02 Jul 2003 18:11:06 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-02 at 17:29, Cédric wrote:
> I've tried 2.4.20, and got the same freeze.
> I didn't try 2.4.19.
> 
> My IDE chipset is VIA® VT8233A (associed with VIA® KT333)
Have you a 40c or 80c cable on the cd-writer?
I have the same problem using a 40c cable. Also if Bios (and windows)
reports on my system that the UDMA is present only in the first channel,
linux kernel activate it also in the second channel (and it works
great!).
-- 
Flameeyes <dgp85@users.sf.net>

