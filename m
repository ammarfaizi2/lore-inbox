Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTJONZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTJONZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:25:19 -0400
Received: from holomorphy.com ([66.224.33.161]:22165 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263154AbTJONZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:25:17 -0400
Date: Wed, 15 Oct 2003 06:28:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031015132824.GS16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org> <20031015121208.GA692@elf.ucw.cz> <20031015125109.GQ16158@holomorphy.com> <20031015132054.GA840@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015132054.GA840@elf.ucw.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 03:20:54PM +0200, Pavel Machek wrote:
> Do you want to say that calculation is different, already? We should
> probably make 2.5 version match 2.4 version, that's what users
> expect. Who changed it and why?

No idea when it changed, but I was at least duly disturbed by the tiny
384KB ZONE_NORMAL materializing out of thin air when I booted mem=16m.


-- wli
