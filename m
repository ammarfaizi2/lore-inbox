Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbREQL7L>; Thu, 17 May 2001 07:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbREQL6V>; Thu, 17 May 2001 07:58:21 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:32411 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261406AbREQL6L>; Thu, 17 May 2001 07:58:11 -0400
Date: Thu, 17 May 2001 13:58:08 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: virii <virii@gcecisp.com>, linux-kernel@vger.kernel.org
Subject: Re: cmpci sound chip lockup
Message-ID: <20010517135808.G754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3B02FE4D.2F7A8E8F@gcecisp.com> <Pine.LNX.4.33.0105162000420.5251-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0105162000420.5251-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, May 16, 2001 at 08:02:06PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 08:02:06PM -0300, Rik van Riel wrote:
> I'm seeing a similar thing on 2.4.4-pre[23], but in a far less
> serious way. Using xmms the music stops after anything between
> a few seconds and a minute, I suspect a race condition somewhere.
> 
> Using mpg123 everything works fine...

Your xmms uses esd[1]?

Friends of mine report problems with esd and 2.4.x. Tested on
SB-Live! and es1371.

Regards

Ingo Oeser

[1] E Sound Deamon - A sound mixing framework
-- 
To the systems programmer,
users and applications serve only to provide a test load.
