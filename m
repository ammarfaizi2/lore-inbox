Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTFPSkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTFPShu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:37:50 -0400
Received: from smtp1.libero.it ([193.70.192.51]:6808 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S264201AbTFPShn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:37:43 -0400
Subject: Re: 2.5.71, fbconsole: No boot logo?
From: Flameeyes <daps_mls@libero.it>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200306162139.30224.kde@myrealbox.com>
References: <3EEE015A.8080601@Synopsys.COM>
	 <200306162139.30224.kde@myrealbox.com>
Content-Type: text/plain
Message-Id: <1055789603.1669.1.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Jun 2003 20:53:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 20:39, ismail (cartman) donmez wrote:
> Try  Graphics support  --->Logo configuration  --->[*] Bootup logo
You can't activate the 224 colors logo without Bootup Logo active.
I have the same problem with these lines in .config

CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

-- 
Flameeyes

