Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265940AbUFOUgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUFOUgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUFOUgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:36:25 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:32411 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265940AbUFOUgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:36:23 -0400
Date: Tue, 15 Jun 2004 22:45:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig help bugreport
Message-ID: <20040615204532.GI2310@mars.ravnborg.org>
Mail-Followup-To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
	linux-kernel@vger.kernel.org
References: <20040615130319.C5811@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615130319.C5811@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 01:03:19PM +0000, Karel Kulhavý wrote:
> Hello
> 
> If I go to the line in make menuconfig reading "USB Human Interface Devices (HID)"
> and enter <Help> I get
> "There is no help available for this option".
> 
> Maybe the help is not intended to be there.
> 
> However what I consider being a bug is that when I <Exit> from the help, the cursor
> jumps at the start of the USB chapter and because USB is lenghty the original
> position is lost.
> 
> This doesn't happem for other entries wher <Help> is available.

Could not reproduce this error with 2.6 kernel.
If this is for the 2.4 kernel it will not be fixed.

	Sam
