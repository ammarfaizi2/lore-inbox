Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130179AbRB1OHq>; Wed, 28 Feb 2001 09:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130180AbRB1OHg>; Wed, 28 Feb 2001 09:07:36 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:48140 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130179AbRB1OHT>;
	Wed, 28 Feb 2001 09:07:19 -0500
Date: Wed, 28 Feb 2001 15:07:11 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: David <david@blue-labs.org>
Cc: Alistair Riddell <ali@gwc.org.uk>,
        "Heusden, Folkert van" <f.v.heusden@ftr.nl>,
        Ivo Timmermans <irt@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010228150711.A12214@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.21.0102271425200.14871-100000@frank.gwc.org.uk> <3A9C36BF.6060608@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A9C36BF.6060608@blue-labs.org>; from david@blue-labs.org on Tue, Feb 27, 2001 at 03:22:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
> We wouldn't make the kernel translate m$ word docs into files the kernel 
> can parse.  It's a userland thing and changing the kernel would change a 
> legacy that would cause a lot of confusion I would expect.

Now there's a thought.  binfmt_fileextension, chooses the interpreter
based on filename :-)

-- Jamie
