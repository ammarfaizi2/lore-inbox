Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272011AbRIDQwR>; Tue, 4 Sep 2001 12:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272015AbRIDQwJ>; Tue, 4 Sep 2001 12:52:09 -0400
Received: from www.transvirtual.com ([206.14.214.140]:57098 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S272003AbRIDQv7>; Tue, 4 Sep 2001 12:51:59 -0400
Date: Tue, 4 Sep 2001 09:52:10 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Wakko Warner <wakko@animx.eu.org>
cc: Simon Hay <simon@haywired.org>, linux-kernel@vger.kernel.org
Subject: Re: Multiple monitors
In-Reply-To: <20010903164953.A3243@animx.eu.org>
Message-ID: <Pine.LNX.4.10.10109040950240.22429-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I thought of doing something like this but using a matrox g400 or g450 dual
> head card.  primary would be for X, secondary would be a console.  Not sure
> if that's more difficult or not.  Something I'd like to have, however.

I have a setup at work like this. I have X running on ATI rage 128 card
and a G400 as a console. I myself sometime ago got 2 independent X servers
running on a multidesktop system (2 monitors, 2 keybaords and 2 mice). In
this case you need to make sure you start the second X server with the -vt
option. 

