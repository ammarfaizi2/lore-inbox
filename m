Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWDOLhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWDOLhD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 07:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWDOLhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 07:37:03 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:37349 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932488AbWDOLhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 07:37:01 -0400
Date: Sat, 15 Apr 2006 15:36:56 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16 ESP4 IPsec processing ported to acrypto.
Message-ID: <20060415113656.GA1357@2ka.mipt.ru>
References: <20060412095017.GA14530@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060412095017.GA14530@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 15 Apr 2006 15:36:56 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New acrypto combined patch for 2.6.16 kernel tree has been released,
which includes asynchronous crypto layer [1] acrypto, dm-crypt, 
ESP4 IPsec processing and software crypto provider ported to acrypto.
Patch [2] and other acrypto drivers are available in archive [3].

1. http://tservice.net.ru/~s0mbre/old/?section=projects&item=acrypto
2. http://tservice.net.ru/~s0mbre/archive/acrypto/drivers/acrypto-combined-2.6.16.diff.1
3. http://tservice.net.ru/~s0mbre/archive/acrypto

-- 
	Evgeniy Polyakov
