Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVLNUUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVLNUUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVLNUUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:20:24 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:51943 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964932AbVLNUUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:20:23 -0500
Subject: Re: Help track down a freezing machine
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <dnp4t9$srl$1@sea.gmane.org>
References: <dnp4t9$srl$1@sea.gmane.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1134591307.10811.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 15 Dec 2005 06:15:07 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-12-14 at 22:55, Kalin KOZHUHAROV wrote:
> Hi, all!
> 
> You know there are weeks (or months!) when everything is just plain wrong... While still fighting
> with my laptop (See "Help track a memory leak in 2.6.0..14), now one of the semi-production machines
> started to freeze without any indication...

Another suggestion is to patch your kernel with kdb or kgdb and turn the
option on when compiling. You could then do more detailed examination of
the issue.

Regards,

Nigel

