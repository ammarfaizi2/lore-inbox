Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVAGTEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVAGTEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVAGTEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:04:53 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:13223 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261529AbVAGTEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:04:51 -0500
Date: Fri, 7 Jan 2005 20:04:26 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: netdev-2.6 queue updated
Message-ID: <20050107190426.GA17017@electric-eye.fr.zoreil.com>
References: <41DE73B5.6080303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DE73B5.6080303@pobox.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
[...]
>   o r8169: oversized driver field for ethtool
>   o r8169: reduce max MTU for large frames
>   o r8169: Large Send enablement
>   o r8169: C 101
>   o r8169: missing netif_poll_enable and irq ack

Imho you can push these changes to mainline (with due credit to
Jon D Mason for its contributions).

--
Ueimor
