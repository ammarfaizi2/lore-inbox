Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270019AbUJHRTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270019AbUJHRTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270068AbUJHRTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:19:46 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:41995 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270019AbUJHRTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:19:16 -0400
Date: Fri, 8 Oct 2004 12:16:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       jgarzik@pobox.com, marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.28-pre3] 3c59x: resync with 2.6
Message-ID: <20041008121653.D14378@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	akpm@osdl.org, jgarzik@pobox.com, marcelo.tosatti@cyclades.com
References: <20041008121307.C14378@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041008121307.C14378@tuxdriver.com>; from linville@tuxdriver.com on Fri, Oct 08, 2004 at 12:13:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 12:13:07PM -0400, John W. Linville wrote:
> Backport of current 3c59x driver (minus EISA/sysfs stuff) from 2.6 to
> 2.4.  This should ease further maintenance in 2.4.

Forgot this:

Signed-off-by: John W. Linville <linville@tuxdriver.com>

-- 
John W. Linville
linville@tuxdriver.com
