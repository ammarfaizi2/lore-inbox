Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130094AbRB1HaE>; Wed, 28 Feb 2001 02:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130082AbRB1H3z>; Wed, 28 Feb 2001 02:29:55 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:56070 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130081AbRB1H3g>; Wed, 28 Feb 2001 02:29:36 -0500
Date: Tue, 27 Feb 2001 23:29:09 -0800
To: Thorsten Glaser Geuer <eccesys@topmail.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mack Stevenson <mackstevenson@hotmail.com>
Subject: Re: ISO-8859-1 completeness of kernel fonts?
Message-ID: <20010227232909.A2599@ferret.phonewave.net>
In-Reply-To: <F281raFC8XymNMDdckH00012e6f@hotmail.com> <000001c0a0ed$1ea188d0$742c9c3e@tp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <000001c0a0ed$1ea188d0$742c9c3e@tp.net>; from eccesys@topmail.de on Tue, Feb 27, 2001 at 04:26:21PM -0000
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all..

I'm interested in making a 16x32 console font, so I can run my 21"
display at 100x37 text. I've asked on the framebuffer list already, but
have heard no reply, and the list seems to be defunct.

Since it's a fixed-frequency display, I want to have the framebuffer and
basic font in-kernel and loaded at boot time. I'm not sure where to find
the necessary tools/documentation to do all the steps, though. Could
someone point me in the right direction?

-- Ferret
