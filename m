Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270201AbRHGXOk>; Tue, 7 Aug 2001 19:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270200AbRHGXOa>; Tue, 7 Aug 2001 19:14:30 -0400
Received: from armitage.toyota.com ([63.87.74.3]:50701 "EHLO
	armitage.toyota.com") by vger.kernel.org with ESMTP
	id <S270201AbRHGXOT>; Tue, 7 Aug 2001 19:14:19 -0400
Message-ID: <3B70764D.E90F96B6@lexus.com>
Date: Tue, 07 Aug 2001 16:14:21 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Noel Koethe <noel@koethe.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x IP aliase max eth0:16 (16 aliases), where to change?
In-Reply-To: <Pine.LNX.4.21.0108072238160.20904-100000@data.wipol.uni-bonn.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noel Koethe wrote:

> Hello,
>
> The maximum aliases I can configure with a 2.4.x kernel is 16, right?

er... I would expect you could do thousands....
It's really a matter of how much RAM and CPU
you have -

> Where I can change this? I want to use more aliases.
> linux/Documentation/networking/alias.txt tells nothing about this limit
> and how to change it.

I haven't seen any such limit - heck, I had over 200
ethernet aliases on a 2.0.x slackware box back in 1996 -

cu

jjs


