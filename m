Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266379AbUFQFgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUFQFgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 01:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266377AbUFQFgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 01:36:21 -0400
Received: from havoc.gtf.org ([216.162.42.101]:49386 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266379AbUFQFfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 01:35:43 -0400
Date: Thu, 17 Jun 2004 01:35:40 -0400
From: David Eger <eger@havoc.gtf.org>
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jsimmons@infradead.org
Subject: Re: [PATCH] fix radeonfb panning and make it play nice with copyarea()
Message-ID: <20040617053540.GA23365@havoc.gtf.org>
References: <20040616182415.GA8286@middle.of.nowhere> <20040617022100.GA11774@havoc.gtf.org> <20040617051931.GA1378@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617051931.GA1378@middle.of.nowhere>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,

While the patch I sent Juriaan didn't work for him, it is a needed bugfix.
Please apply to -mm.  I'm continuing to try to track down his issue...

-dte
