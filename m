Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTLUXpg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTLUXpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 18:45:36 -0500
Received: from ping.ovh.net ([213.186.33.13]:32666 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S263946AbTLUXpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 18:45:35 -0500
Date: Mon, 22 Dec 2003 00:43:50 +0100
From: Octave <oles@ovh.net>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031221234350.GD4897@ovh.net>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221184709.GO25043@ovh.net> <20031221185959.GE1494@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031221185959.GE1494@louise.pinerecords.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 07:59:59PM +0100, Tomas Szepe wrote:
> On Dec-21 2003, Sun, 19:47 +0100
> Octave <oles@ovh.net> wrote:
> 
> > You can run this easy script. 2.4.19 takes about 30 minutes 
> > to kill all process. 2.4.23 takes about 60 minutes.
> 
> Can you also try 2.4.24-pre1 with the OOM killer enabled?

I complied 2.4.24-pre1 with OOM killer. After 2 minutes of
test, server is down. 

Octave

