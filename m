Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUALSIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 13:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUALSIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 13:08:07 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:23943 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265598AbUALSIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 13:08:05 -0500
Date: Mon, 12 Jan 2004 10:07:56 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dag Nygren <dag@newtech.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Added disk activity from 2.6.0 to 2.6.1
Message-ID: <20040112180756.GG17845@matchmail.com>
Mail-Followup-To: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org
References: <20040112180307.3626.qmail@dag.newtech.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112180307.3626.qmail@dag.newtech.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 08:03:07PM +0200, Dag Nygren wrote:
> 
> Hi,
> 
> some days ago I installed 2.6.1 here and immediately
> noticed a slower bootup time.
> The disk during boot is also very much  showing a lot more
> activity.
> And the same when starting up a new program.
> Was there a change that explains this?
> 
> I just reinstalled 2.6.0 and everything went back to being
> quite peaceful.

Run "vstat 1" while you're seeing the problem with 2.6.1, and post it here.
