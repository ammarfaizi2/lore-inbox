Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937764AbWLFXKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937764AbWLFXKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937773AbWLFXKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:10:00 -0500
Received: from paragon.brong.net ([66.232.154.163]:40648 "EHLO
	paragon.brong.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937764AbWLFXJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:09:59 -0500
Date: Thu, 7 Dec 2006 10:09:49 +1100
From: Bron Gondwana <brong@fastmail.fm>
To: filip@euroweb97.com
Cc: support@areca.com.tw, linux-kernel@vger.kernel.org, erich@areca.com.tw
Subject: Re: Areca driver 2.6.19 on x86_64
Message-ID: <20061206230949.GA25461@brong.net>
References: <3193.213.203.144.13.1165423892.squirrel@mailserver.omnibit.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3193.213.203.144.13.1165423892.squirrel@mailserver.omnibit.it>
Organization: brong.net
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 05:51:32PM +0100, filip@euroweb97.com wrote:
> OS distro used:
> CentOS 4.4 x86_64
> Kernel 2.6.19 with hand-crafted config, that we are
> able to use successfully with kernel 2.6.16.20.

What patches were you applying to 2.6.16.20, since that didn't
have an Areca driver in it I presume you're at least using that.

> Have you any suggestions to resolve this issue ?

32 bit kernel?  I'm somewhat serious here, depending what applications
you're running on the machine.

Otherwise, no clue sorry - we're running 32 bit kernels everywhere
even on the couple of new Core machines we have.

Bron.
