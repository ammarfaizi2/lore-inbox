Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317773AbSGVSDM>; Mon, 22 Jul 2002 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317782AbSGVSDL>; Mon, 22 Jul 2002 14:03:11 -0400
Received: from unthought.net ([212.97.129.24]:39299 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S317781AbSGVSDI>;
	Mon, 22 Jul 2002 14:03:08 -0400
Date: Mon, 22 Jul 2002 20:06:16 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] core file names
Message-ID: <20020722180616.GE11081@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <1027358351.12656.24.camel@albatros>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1027358351.12656.24.camel@albatros>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 07:19:11PM +0200, Jes Rahbek Klinke wrote:
> This patch agains linux-2.4.18 will allow you to configure the way core
> files are named through the /proc filesystem.
...

Marcelo, any chance of getting this into 2.4.20 ?

The patch doesn't break existing functionality as far as I can see, and
it's extremely useful for Beowulf-type people, among others.

It even removes a few embarassments from the existing code  :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
