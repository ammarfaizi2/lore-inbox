Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbVG3LZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbVG3LZV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 07:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVG3LZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 07:25:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:179 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263036AbVG3LZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 07:25:19 -0400
Date: Sat, 30 Jul 2005 13:22:28 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Andrew Hutchings <info@a-wing.co.uk>, jgarzik@pobox.com
Subject: Re: [patch 2.6.13-rc3] sis190 driver
Message-ID: <20050730112228.GB22959@electric-eye.fr.zoreil.com>
References: <13196579.1122721928715.JavaMail.www@wwinf0801>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13196579.1122721928715.JavaMail.www@wwinf0801>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> By the way,  i still can not force speed/mode/autoneg (ethtool or mii-tool); 
> ethtool reports correctly the changes, but autoneg is not really disabled, 
> and the driver falls back to 100 Full...
> 
> Had Lars better results with autoneg off?

I doubt it. So far this is a known feature :o)

--
Ueimor
