Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUENSvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUENSvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUENStw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:49:52 -0400
Received: from host206.200-117-132.telecom.net.ar ([200.117.132.206]:58821
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S262100AbUENSse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:48:34 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: does udev support sw raid0?
Date: Fri, 14 May 2004 15:48:32 -0300
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>
References: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx> <20040514183450.GA2345@kroah.com>
In-Reply-To: <20040514183450.GA2345@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405141548.32602.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, May 14, 2004 at 02:42:38PM -0300, Norberto Bensa wrote:
> > I'm trying to setup my box to use udev but I'm stuck.
> Do your md raid devices show up in /sys/block?  If so, then udev should
> support them.  If not, then udev will not.

No if I boot with devfs=nomount. Yes otherwise.

Regards,
Norberto
