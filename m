Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTIVUZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTIVUZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:25:30 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:2316 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263280AbTIVUZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:25:29 -0400
Date: Mon, 22 Sep 2003 22:25:27 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: John Bradford <john@grabjohn.com>
Cc: aebr@win.tue.nl, ndiamond@wta.att.ne.jp, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Translated set 3
Message-ID: <20030922222527.B1064@pclin040.win.tue.nl>
References: <200309221242.h8MCgtMf000302@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309221242.h8MCgtMf000302@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Mon, Sep 22, 2003 at 01:42:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 01:42:55PM +0100, John Bradford wrote:

> Why not simplify the whole problem, and either have:
> 
> * translated set 2 with workarounds for all known strange keyboards
> * untranslated set 3

Yes, you need untranslated set 3, everybody else on i386 needs
translated set 2.

(Other architectures do not do any translation and probably need
untranslated set 2.)

(Very rarely, one sees untranslated set 1 on i386.)

Let us wait and see what Vojtech creates.

