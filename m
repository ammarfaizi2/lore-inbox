Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262118AbREPXDN>; Wed, 16 May 2001 19:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbREPXDD>; Wed, 16 May 2001 19:03:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41746 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262118AbREPXCx>; Wed, 16 May 2001 19:02:53 -0400
Date: Wed, 16 May 2001 20:02:06 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: virii <virii@gcecisp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: cmpci sound chip lockup 
In-Reply-To: <3B02FE4D.2F7A8E8F@gcecisp.com>
Message-ID: <Pine.LNX.4.33.0105162000420.5251-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0105162000422.5251@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2001, virii wrote:

> The attatched file is the format for reporting bugs.

Too bad my mailreader doesn't quote that thing .. oh well, lets
just replace your bugreport with mine ;)

I'm seeing a similar thing on 2.4.4-pre[23], but in a far less
serious way. Using xmms the music stops after anything between
a few seconds and a minute, I suspect a race condition somewhere.

Using mpg123 everything works fine...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

