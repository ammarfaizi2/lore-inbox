Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271809AbRICUoD>; Mon, 3 Sep 2001 16:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271813AbRICUnz>; Mon, 3 Sep 2001 16:43:55 -0400
Received: from dsl-212-135-211-72.dsl.easynet.co.uk ([212.135.211.72]:60165
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S271809AbRICUnm>; Mon, 3 Sep 2001 16:43:42 -0400
Date: Mon, 3 Sep 2001 21:42:41 +0100 (BST)
From: Simon Hay <simon@haywired.org>
X-X-Sender: <sjeh@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Multiple monitors
In-Reply-To: <20010903164953.A3243@animx.eu.org>
Message-ID: <Pine.LNX.4.33.0109032139340.2297-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001, Wakko Warner wrote:

> I thought of doing something like this but using a matrox g400 or g450 dual
> head card.  primary would be for X, secondary would be a console.  Not sure
> if that's more difficult or not.  Something I'd like to have, however.
>

I don't know how the Matrox cards work so I couldn't comment, although
presumably having code to support multiple monitors on multiple cards
would at least make it _easier_ to support dual head video adaptors.
Also, presumably if you could assign virtual consoles to either monitor
and they both behaved like the standard primary console there'd be no
particular reason why X shouldn't run on one or both as normal...

Simon

