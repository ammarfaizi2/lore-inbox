Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSFRHaJ>; Tue, 18 Jun 2002 03:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317353AbSFRHaH>; Tue, 18 Jun 2002 03:30:07 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:21409 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317352AbSFRH2W>; Tue, 18 Jun 2002 03:28:22 -0400
Date: Tue, 18 Jun 2002 09:26:38 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isdn oops with 2.4.19-pre10
Message-Id: <20020618092638.569cc33c.kristian.peters@korseby.net>
In-Reply-To: <Pine.LNX.4.44.0206171053450.22308-100000@chaos.physics.uiowa.edu>
References: <20020617174746.0b8ec0a4.kristian.peters@korseby.net>
	<Pine.LNX.4.44.0206171053450.22308-100000@chaos.physics.uiowa.edu>
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-pre10-ac2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
> Actually that's the case I was thinking of. capidrv gets loaded last, but 
> is not removed first.
> 
> Could you try if the appended patch fixes it?

Yes. I can't reproduce it anymore.
I hope Marcelo accepts this for a 2.4.19-rc.

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
