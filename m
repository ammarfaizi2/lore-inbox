Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbRE2IuU>; Tue, 29 May 2001 04:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbRE2IuK>; Tue, 29 May 2001 04:50:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:773 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261425AbRE2It5> convert rfc822-to-8bit; Tue, 29 May 2001 04:49:57 -0400
Date: Tue, 29 May 2001 04:13:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
Cc: "G. Hugh Song" <ghsong@kjist.ac.kr>, linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM...
In-Reply-To: <20010529061039.D29962@unthought.net>
Message-ID: <Pine.LNX.4.21.0105290407350.1660-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 May 2001, Jakob Østergaard wrote:

> 
> It's not a bug.  It's a feature.  It only breaks systems that are run with "too
> little" swap, and the only difference from 2.2 till now is, that the definition
> of "too little" changed.

Its just a balancing change, actually. You can tune the code to reap cache
aggressively.

"just put more swap and you're OK" is not the answer, IMO. 

