Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSKSIZ7>; Tue, 19 Nov 2002 03:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSKSIZ7>; Tue, 19 Nov 2002 03:25:59 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:25236 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264646AbSKSIZ7>; Tue, 19 Nov 2002 03:25:59 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Rik van Riel <riel@conectiva.com.br>, deepak <dxbadami@wichita.edu>
Subject: Re: patch
Date: Tue, 19 Nov 2002 08:33:20 +0100
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0211182119470.4103-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0211182119470.4103-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200211190833.20443.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 November 2002 00:20, Rik van Riel wrote:
> On Mon, 18 Nov 2002, deepak wrote:
> > how do i uninstall a patch
>
> $ man patch
> ...
>        -R  or  --reverse
>           Assume that this patch was created with the old and new
>           files swapped.  (Yes, I'm afraid that does happen occa­
>           sionally,  human  nature  being  what  it  is.)   patch
>           attempts  to  swap each hunk around before applying it.
>           Rejects come out in the swapped format.  The -R  option
> 	  ...
>
> Next time you should read the man page yourself ;)

Come on, be fair.  This text is pretty obscure.  If you didn't know so
already, would you understand from it that -R undoes a patch?

Duncan.
