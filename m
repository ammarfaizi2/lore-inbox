Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUJDQJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUJDQJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUJDQJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:09:57 -0400
Received: from web1.mmaero.com ([67.98.186.98]:58018 "EHLO web1.mmaero.com")
	by vger.kernel.org with ESMTP id S267619AbUJDQJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:09:04 -0400
Date: Mon, 4 Oct 2004 12:09:02 -0400 (EDT)
From: Jon Lewis <jlewis@lewis.org>
X-X-Sender: jlewis@web1.mmaero.com
To: William Knop <wknop@andrew.cmu.edu>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: <Pine.LNX.4.60-041.0410041132070.9105@unix43.andrew.cmu.edu>
Message-ID: <Pine.LNX.4.58.0410041206060.26615@web1.mmaero.com>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
 <Pine.LNX.4.58.0410040953160.26615@web1.mmaero.com>
 <Pine.LNX.4.60-041.0410041132070.9105@unix43.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004, William Knop wrote:

> Ah, well all of them are Maxtor drives... One 6y250m0 and three 7y250m0
> drives. I'm using powermax on them right now. They all passed the quick
> test, and the full test results are forthcoming.

I'm pretty sure all the bad ones we had (at least the one I found at my
location) "failed" the quick test in that after the quick test it asked me
to run the full test, after which it spit out the magic fault code to give
Maxtor's RMA form.  Another possibility that comes to mind is that your
power supply could be inadequate to run the system and all the drives.

----------------------------------------------------------------------
 Jon Lewis                   |  I route
 Senior Network Engineer     |  therefore you are
 Atlantic Net                |
_________ http://www.lewis.org/~jlewis/pgp for PGP public key_________
