Return-Path: <linux-kernel-owner+w=401wt.eu-S932101AbXAVRX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbXAVRX0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 12:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXAVRX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 12:23:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24497 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbXAVRXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 12:23:25 -0500
Date: Mon, 22 Jan 2007 12:23:24 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [Announce] GIT v1.5.0-rc2
In-reply-to: <45B3C3B4.6000706@zytor.com>
X-X-Sender: nico@xanadu.home
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Junio C Hamano <junkio@cox.net>, Willy Tarreau <w@1wt.eu>,
       git@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0701221220300.3011@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
 <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <20070121134308.GA24090@1wt.eu>
 <7v7ivg1a25.fsf@assigned-by-dhcp.cox.net> <45B3C3B4.6000706@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007, H. Peter Anvin wrote:

> In general, though, I would agree that the major number should change if there
> is an incompatible change.

Maybe when those incompatible features are enabled by default.  Right 
now they're not.


Nicolas
