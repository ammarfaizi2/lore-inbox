Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVC2QFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVC2QFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVC2QFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:05:49 -0500
Received: from dvhart.com ([64.146.134.43]:14987 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261177AbVC2QFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:05:46 -0500
Message-ID: <42497D1D.5090301@mauery.com>
Date: Tue, 29 Mar 2005 08:06:53 -0800
From: Vernon Mauery <vernon@mauery.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mister Google <binary-nomad@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keystroke simulator
References: <BAY10-F55DA0F654CE67C2B4DC2F684450@phx.gbl>
In-Reply-To: <BAY10-F55DA0F654CE67C2B4DC2F684450@phx.gbl>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mister Google wrote:
> Is there a way to simulate a keystroke to a program, ie. have a program
> send it something so that as far as it's concerned, say, the "P" key has
> been pressed?
> 
Look at the input system.  Documentation/input/input-programming.txt has a great tutorial on how to do this.  

--Vernon

