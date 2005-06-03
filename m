Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFCLn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFCLn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 07:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFCLnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 07:43:55 -0400
Received: from styx.suse.cz ([82.119.242.94]:10960 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261222AbVFCLnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 07:43:51 -0400
Date: Fri, 3 Jun 2005 13:43:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Green Brain <greenbrain@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WebCamera
Message-ID: <20050603114350.GA13435@ucw.cz>
References: <002c01c56628$19ccbbe0$7344c5d5@windows>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002c01c56628$19ccbbe0$7344c5d5@windows>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 11:27:31PM +0200, Green Brain wrote:

> I cannot use my USB 2.0 (BisonCam, ALI M5603C chip) webcamera under
> (SuSE) Linux. If somebody know this camera please help me! (I use a
> Clevo notebook.) Thanks in advance!

Unfortunately, there is no M5603c driver for Linux. While I'm planning
to write one (I have eight cameras based on it), I didn't manage to get
specs from ALi, so it'll be rather hard to write the driver.

There is a project by Luca Risolia, but it doesn't seem very active so
far. See http://www.linux-projects.org/modules/news/.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
