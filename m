Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272050AbTHDVlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272222AbTHDVlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:41:19 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:4503
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272050AbTHDVlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:41:16 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 07:46:29 +1000
User-Agent: KMail/1.5.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200307280112.16043.kernel@kolivas.org> <1060023104.889.7.camel@teapot.felipe-alfaro.com> <1060023516.511.0.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1060023516.511.0.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308050746.29140.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 04:58, Felipe Alfaro Solana wrote:
> OK, I had the X server reniced at -20... Renicing the X server at +0
> makes the XMMS skips disappear. At least, with X at +0 I've been able to
> reproduce them anymore.

As always, thanks Felipe.

This is good news. X should be able to make xmms skip if it's -20, and X 
should still be smooth at 0. 

Con

