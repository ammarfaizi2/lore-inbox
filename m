Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbUK1QrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbUK1QrE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUK1Qpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:45:45 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:11795 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261515AbUK1QkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:40:19 -0500
Date: Wed, 17 Nov 2004 20:25:38 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, alan@redhat.com
Subject: Re: [patch 2.6.10-rc2] oss: AC97 quirk facility
Message-ID: <20041118012537.GB22765@tuxdriver.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com, alan@redhat.com
References: <20041117163016.A5351@tuxdriver.com> <20041117145644.005e54ff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117145644.005e54ff.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 02:56:44PM -0800, Andrew Morton wrote:
> "John W. Linville" <linville@tuxdriver.com> wrote:

> > The code is stolen shamelessly from ALSA, FWIW...
> 
> Dumb question: why not just use the ALSA driver?

Makes sense to me.  This was mostly done for 2.4 kernels using OSS.

I posted the 2.6-based patch mostly 'for completeness'...and to help
the OSS hold-outs... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
