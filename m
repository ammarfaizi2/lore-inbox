Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRCAUKj>; Thu, 1 Mar 2001 15:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbRCAUKY>; Thu, 1 Mar 2001 15:10:24 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:45400 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129175AbRCAUKR>;
	Thu, 1 Mar 2001 15:10:17 -0500
Message-ID: <20010301211016.B21460@win.tue.nl>
Date: Thu, 1 Mar 2001 21:10:16 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: "Sébastien HINDERER" <jrf3@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Escape sequences & console
In-Reply-To: <3a9ea6fa3b646cc9@citronier.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.93i
In-Reply-To: <3a9ea6fa3b646cc9@citronier.wanadoo.fr>; from
  Sébastien HINDERER on Thu, Mar 01, 2001 at 08:48:1
 0PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 08:48:10PM -0000, Sébastien HINDERER wrote:

> According to linux/drivers/console.c, function setterm_commands, case 12,
> one can change the virtual console by sending an escape sequence to
> /dev/cnsole (what I want to do), hower, this is not documented in man
> pages.

Hmm. How come I read

       ESC [ 12 ; n ]      Bring specified console to the front.

?

