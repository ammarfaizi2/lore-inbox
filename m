Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVIUKLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVIUKLf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVIUKLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:11:35 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:23014 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750807AbVIUKLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:11:34 -0400
Date: Wed, 21 Sep 2005 12:07:36 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bgs <bgs@bgs.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: probs with realtek 8110/8169 NIC
Message-ID: <20050921100736.GA21341@electric-eye.fr.zoreil.com>
References: <4331229D.9050302@bgs.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4331229D.9050302@bgs.hu>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please:
- try 2.6.14-rc2
- open a problem report at http://bugzilla.kernel.org
- send a _complete_ dmesg/lspci -vx/lsmod 
- send the vlan-related commands

--
Ueimor
