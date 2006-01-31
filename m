Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWAaSYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWAaSYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWAaSYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:24:32 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:28078 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751322AbWAaSYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:24:31 -0500
Date: Tue, 31 Jan 2006 19:19:52 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andy Gospodarek <andy@greyhouse.net>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RealTek RTL-8169 Full Duplex Patch
Message-ID: <20060131181952.GA20574@electric-eye.fr.zoreil.com>
References: <20060130161029.GA11938@gospo.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130161029.GA11938@gospo.rdu.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Gospodarek <andy@greyhouse.net> :
> Allow the r8129 driver to set devices to be full-duplex only when
> auto-negotiate is disabled.

s/8129/8169 and added to the branch 'for-jeff' at
git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git

-- 
Ueimor
