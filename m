Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUD1N7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUD1N7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbUD1N7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:59:36 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:11664 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264788AbUD1N7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:59:35 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Wed, 28 Apr 2004 15:59:06 +0200
From: stefan.eletzhofer@eletztrick.de
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add RTC 8564 I2C chip support
Message-ID: <20040428135906.GA23534@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	linux-kernel@vger.kernel.org
References: <20040428134122.GB23076@gonzo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428134122.GB23076@gonzo.local>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 03:41:22PM +0200, Stefan Eletzhofer wrote:
> Hi,
> the attached patch adds support for the Epson 8564 RTC
> chip. This chip is a generic real-time-clock sitting on
> a I2C bus.

Duh, it's against 2.6.6-rc2 :)

> 
> Patch URL:
> http://213.239.196.168/~seletz/patches/2.6.6-rc2/i2c-rtc8564.patch
> 
> Please comment,
> 	Stefan E.
> 
> 
