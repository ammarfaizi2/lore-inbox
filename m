Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263524AbTDIPgh (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTDIPgh (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:36:37 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:50201 "EHLO
	dyn94194207.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263524AbTDIPgf (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 11:36:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Steven Cole <elenstev@mesatop.com>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.5.67 - reiserfs go boom.
Date: Wed, 9 Apr 2003 10:48:07 -0500
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030409011802.GD25834@suse.de> <1049853413.31551.27.camel@spc>
In-Reply-To: <1049853413.31551.27.camel@spc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304091048.07659.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 April 2003 20:56, Steven Cole wrote:
> On Tue, 2003-04-08 at 19:18, Dave Jones wrote:
> > Whilst running fsx.. (Though fsx didn't trigger any error,
> > and is still running)..
>
> Gee, that looks remarkably similar to what I was getting
> with ext3.  This happened on every boot with 2.5.67 with
> the base distro being Mandrake 9.1.  Then, I replaced LM 9.1
> with Redhat 9 and I never saw this again with 2.5.67.

FWIW, I've seen the same thing on JFS.  :^)
-- 
David Kleikamp
IBM Linux Technology Center

