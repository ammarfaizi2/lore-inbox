Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291654AbSBHRMU>; Fri, 8 Feb 2002 12:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291661AbSBHRMK>; Fri, 8 Feb 2002 12:12:10 -0500
Received: from www.transvirtual.com ([206.14.214.140]:37646 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291654AbSBHRMG>; Fri, 8 Feb 2002 12:12:06 -0500
Date: Fri, 8 Feb 2002 09:11:58 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: "Axel H. Siebenwirth" <axel@hh59.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: psaux mouse support not working with gpm
In-Reply-To: <20020207215434.GA12899@neon>
Message-ID: <Pine.LNX.4.10.10202080911290.18628-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have an optical ps2 mouse by Typhoon with a resolution of 400dpi. No
> matter wether using protocol ps2 or imps2 the mouse cursor is moving very
> disrupted (can't find the right word), not fluent at all, also causing key
> strikes.
> Is this a kernel problem? Can't figure out any other place to look at. gpm
> seems ok.

Which kernel? Have you tried the DJ tree using the new input api PS/2
drivers?

