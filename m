Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290590AbSBFO6Z>; Wed, 6 Feb 2002 09:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290592AbSBFO6P>; Wed, 6 Feb 2002 09:58:15 -0500
Received: from [202.172.46.73] ([202.172.46.73]:57605 "HELO mail.celestix.com")
	by vger.kernel.org with SMTP id <S290590AbSBFO6D>;
	Wed, 6 Feb 2002 09:58:03 -0500
Date: Wed, 6 Feb 2002 22:25:40 +0800
From: Thibaut Laurent <thibaut@celestix.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cyrix CX5530 audio support?
Message-Id: <20020206222540.59011685.thibaut@celestix.com>
In-Reply-To: <Pine.LNX.4.30.0202061524480.6614-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0202061524480.6614-100000@mustard.heime.net>
Organization: Celestix Networks Pte Ltd
X-Mailer: Sylpheed version 0.7.0claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002 15:26:40 +0100 (CET)
Roy Sigurd Karlsbakk <roy@karlsbakk.net> wrote:

 | hi
 | 
 | Are there any support for the CX5530 audio chipset yet?

The sb module from the kernel works.
IIRC, sb16 had a hard time detecting the chip (though I haven't tested it again recently), but ALSA snd-card-sb16 is all right so you'll probably want to use the later.

 | 
 | roy
 | 
 | --
 | Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
 | 
 | Computers are like air conditioners.
 | They stop working when you open Windows.


Regards,
Thibaut

