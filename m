Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTKBHoY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 02:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTKBHoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 02:44:24 -0500
Received: from CPE-144-132-198-235.nsw.bigpond.net.au ([144.132.198.235]:1670
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id S261546AbTKBHoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 02:44:23 -0500
Date: Sun, 2 Nov 2003 15:28:42 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [patch] reproducible athlon mce fix
Message-ID: <20031102072842.GA9813@anakin.wychk.org>
References: <20031102055748.GA1218@anakin.wychk.org> <20031102072519.GD530@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <20031102072519.GD530@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 08:25:19AM +0100, Willy Tarreau wrote:
> Hi,
> 
> 
> Other solutions to this problem often include one of these constructs
> which are unfortunately not as beautiful :
> 


Hi,

Yep, I know it's ugly, but what I am really after is whether the patch
is correct or not, in terms of what it does.

If it's correct we can work out how to fix this properly, since non-fatal.c
is generic code and I am not sure if doing a CONFIG_MK7 like that is very
pretty there anyway ...

	- g.
