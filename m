Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283486AbRLDUqX>; Tue, 4 Dec 2001 15:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283463AbRLDUoz>; Tue, 4 Dec 2001 15:44:55 -0500
Received: from zero.tech9.net ([209.61.188.187]:52484 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283349AbRLDUoC>;
	Tue, 4 Dec 2001 15:44:02 -0500
Subject: Re: kapm-idled
From: Robert Love <rml@tech9.net>
To: Gert Menke <gert@menke.za.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011204211833.A1364@mouse.mydomain>
In-Reply-To: <20011204211833.A1364@mouse.mydomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Dec 2001 15:43:52 -0500
Message-Id: <1007498633.16169.22.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-04 at 15:18, Gert Menke wrote:

> I just compiled 2.4.16 for my notebook with "Make CPU Idle calls when idle"
> enabled. Now kapm-idled uses up to 50% cpu when the system is otherwise
> idle. Is that correct? It is quite disturbing to have 50% System load when
> the system is supposed to be idle.

Yes, this is the correct behavior.  I agree it is annoying.

	Robert Love

