Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVAEMIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVAEMIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 07:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVAEMIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 07:08:41 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:4496 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262352AbVAEMIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 07:08:35 -0500
Date: Wed, 5 Jan 2005 13:07:12 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 TCP troubles
Message-ID: <20050105120712.GA3728@electric-eye.fr.zoreil.com>
References: <05081I514@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05081I514@server5.heliogroup.fr>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau <hubert.tonneau@fullpliant.org> :
> Here is the senario:
> the Linux machine is writting through libsmbclient
> to an OSX machine running Samba
> 
> Switching the Linux machine from 2.6.8 to 2.6.10 made the network speed
> drop drastically: 20 seconds with 2.6.8, 800 seconds with 2.6.10

Are there any differences in:
- dmesg output
- /proc/interrupts 
- disk traffic
- tcpdump output (of course there will)

--
Ueimor
