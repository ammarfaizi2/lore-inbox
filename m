Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUALMWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbUALMWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:22:32 -0500
Received: from intra.cyclades.com ([64.186.161.6]:44495 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266157AbUALMWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:22:31 -0500
Date: Mon, 12 Jan 2004 10:18:04 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, sim@netnation.com,
       linux-kernel@vger.kernel.org,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: 2.4.24 SMP lockups
In-Reply-To: <Pine.LNX.4.44.0401102311310.14466-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58L.0401121016350.5007@logos.cnet>
References: <Pine.LNX.4.44.0401102311310.14466-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Jan 2004, Rik van Riel wrote:

> On Sat, 10 Jan 2004, Andrew Morton wrote:
>
> > We don't have an each-CPU backtrace facility - it could be handy.
> > There's one in the low-latency patch for some reason.
>
> There's one in the RHEL3 tree, too.
>
> Marcelo, do you want me to rediff it and send it to you ?

Yep, that will be helpful.

Arkadiusz, sysrq-{t,q} from your case too would be nice to have.

