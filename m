Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVJGKy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVJGKy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 06:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJGKy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 06:54:26 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:25289 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751284AbVJGKy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 06:54:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] vm - swap_prefetch-15
Date: Fri, 7 Oct 2005 20:54:10 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200510070001.01418.kernel@kolivas.org> <84144f020510070303u13872f33hb4a40451acea4d5a@mail.gmail.com>
In-Reply-To: <84144f020510070303u13872f33hb4a40451acea4d5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510072054.11145.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005 20:03, Pekka Enberg wrote:
> Hi Con,
>
> A teeny-weeny nitpick:
>
> On 10/6/05, Con Kolivas <kernel@kolivas.org> wrote:
> > +struct swapped_root_t {
>
> [snip]
>
> > +struct swapped_entry_t {
>
> [snip]
>
> Since these are not typedefs, please drop the _t postfix.

Good point, thanks! Any and all feedback is appreciated.

Cheers,
Con
