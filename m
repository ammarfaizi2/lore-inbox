Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161445AbWKHS2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161445AbWKHS2p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWKHS2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:28:45 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:28126 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1754643AbWKHS2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:28:44 -0500
Date: Wed, 8 Nov 2006 19:26:58 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
Subject: Re: New laptop - problems with linux
Message-ID: <20061108182658.GA21154@electric-eye.fr.zoreil.com>
References: <4551EC86.5010600@seclark.us> <4551F3A6.8040807@gmail.com> <4551F5B7.1050709@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4551F5B7.1050709@seclark.us>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark <Stephen.Clark@seclark.us> :
[...]
> No it is not loaded - i did a modprobe on it and it loaded but still no 
> ethx device.

Send complete 'dmesg' and 'lspci -vvx' (please Cc: netdev@vger.kernel.org)

-- 
Ueimor
