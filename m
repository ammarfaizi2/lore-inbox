Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVBWQWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVBWQWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 11:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVBWQWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 11:22:54 -0500
Received: from mxsf37.cluster1.charter.net ([209.225.28.162]:16797 "EHLO
	mxsf37.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261208AbVBWQWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 11:22:53 -0500
X-Ironport-AV: i="3.90,109,1107752400"; 
   d="scan'208"; a="589395519:sNHT1180994292"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16924.44497.352709.72717@smtp.charter.net>
Date: Wed, 23 Feb 2005 11:22:41 -0500
From: "John Stoffel" <john@stoffel.org>
To: Sebastian Fabrycki <cellsan@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Storage problem (usb hangs)
In-Reply-To: <20050220172608.GA2944@globtel.pl>
References: <20050220172608.GA2944@globtel.pl>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sebastian,

Try upgrading to 2.6.11-rc2-mm4 or newer, I've had better luck with my 
USB/Firewire external case on there.  Just make sure you don't turn on
usb-storage logging, it's way too verbose for general use!  

John
