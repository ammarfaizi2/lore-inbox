Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVAESsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVAESsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVAESsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:48:40 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:44690 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262554AbVAESsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:48:37 -0500
Date: Wed, 5 Jan 2005 19:44:45 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 TCP troubles
Message-ID: <20050105184445.GA8996@electric-eye.fr.zoreil.com>
References: <0508ECY12@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0508ECY12@server5.heliogroup.fr>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau <hubert.tonneau@fullpliant.org> :
[...]
> The problem seems to me to be related to the way the TCP layer is handling small
> troubles (probably lost packets on the Mac side because the Linux machine is
> gigabit connected to the switch, with flow control enabled, and the Mac is
> 100 Mbps connected, full duplex, but without flow control).

tcpdump should enlighten it.

--
Ueimor
