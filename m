Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318195AbSGWTYp>; Tue, 23 Jul 2002 15:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318197AbSGWTYp>; Tue, 23 Jul 2002 15:24:45 -0400
Received: from pc-62-30-72-138-ed.blueyonder.co.uk ([62.30.72.138]:36498 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318195AbSGWTYo>; Tue, 23 Jul 2002 15:24:44 -0400
Date: Tue, 23 Jul 2002 20:27:41 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] extended VM stats
Message-ID: <20020723202741.D27897@redhat.com>
References: <Pine.LNX.4.44L.0207151835120.12241-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0207151835120.12241-100000@imladris.surriel.com>; from riel@conectiva.com.br on Mon, Jul 15, 2002 at 07:00:54PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 15, 2002 at 07:00:54PM -0300, Rik van Riel wrote:

> the patch below (against 2.5.25 + minimal rmap) implements a
> number of extra VM statistics, which should help us a lot in
> finetuning the VM for 2.6.

I'd love to see these available per-zone.

Cheers,
 Stephen
