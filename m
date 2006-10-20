Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992548AbWJTMEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992548AbWJTMEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992595AbWJTMEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:04:22 -0400
Received: from twin.jikos.cz ([213.151.79.26]:9410 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S2992548AbWJTMEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:04:22 -0400
Date: Fri, 20 Oct 2006 14:04:09 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Gabriel C <nix.or.die@googlemail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
In-Reply-To: <4538BA2E.9040808@googlemail.com>
Message-ID: <Pine.LNX.4.64.0610201403090.29022@twin.jikos.cz>
References: <20061020015641.b4ed72e5.akpm@osdl.org> <4538BA2E.9040808@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Gabriel C wrote:

> I got this on ' make silentoldconfig '
> drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config
> symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'

This is not a new warning, and should already be fixed for some two weeks 
or so in the v4l-dvb tree.

-- 
Jiri Kosina
