Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbTLHESE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 23:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbTLHESD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 23:18:03 -0500
Received: from holomorphy.com ([199.26.172.102]:11738 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265327AbTLHESA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 23:18:00 -0500
Date: Sun, 7 Dec 2003 20:17:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rafal Skoczylas <nils@secprog.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.test11 bug
Message-ID: <20031208041741.GC8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rafal Skoczylas <nils@secprog.org>, linux-kernel@vger.kernel.org
References: <20031208034631.GA14081@secprog.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208034631.GA14081@secprog.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 04:46:31AM +0100, Rafal Skoczylas wrote:
> I am experiencing similiar behaviour as described below.
> In my case it is mlnetd (of mldonkey package) which seems to be
> responsible for driving kernel to a crash[1].
> After a few hours of running, either the process gets killed or system
> crashes (I am only able to reboot it with alt+prntscr+b, but it seems
> like it is not able to [S]ync or [U]nmount filesystems - i have lost
> a few files which were open at the time of crash[2]).
> It may be worth to mention that I don't remember having such a crash
> on 2.6.0-test9 which i used for a couple of weeks (since first day
> it apeared on ftp.kernel.org untill test11 - i skipped test10).

I'm grabbing mldonkey and taking it for a spin.


-- wli
