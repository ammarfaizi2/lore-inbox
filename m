Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTEZPLF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 11:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTEZPLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 11:11:05 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:40456 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S261414AbTEZPLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 11:11:04 -0400
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
To: eric@cisu.net
Subject: Re: New make config options
Date: Mon, 26 May 2003 17:24:21 +0200
User-Agent: KMail/1.5.2
References: <200305261004.25297.eric@cisu.net>
In-Reply-To: <200305261004.25297.eric@cisu.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305261724.23712.rudmer@legolas.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what about `make allmodconfig` ??

then you have a .config with most things as module and you can always use 
`make menuconfig` to adjust it.

BTW try a `make help` to see all other make options.

	Rudmer

