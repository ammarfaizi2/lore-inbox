Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUACBcH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 20:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbUACBcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 20:32:07 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:55558 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265784AbUACBcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 20:32:05 -0500
Date: Fri, 2 Jan 2004 22:27:27 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UNICODE ioctls on background console
Message-ID: <20040102222727.A3038@pclin040.win.tue.nl>
References: <200401022233.12115.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401022233.12115.arvidjaar@mail.ru>; from arvidjaar@mail.ru on Fri, Jan 02, 2004 at 10:33:12PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 10:33:12PM +0300, Andrey Borzenkov wrote:

> Why are those ioctls forcibly applied to foreground console only?

Funny that you ask precisely now.
Current source has this patch already.

It very slightly changes the documented interface of these ioctls.
I made kbd-1.09 yesterday evening. Expect to put it the usual places
later tonight.

Andries

