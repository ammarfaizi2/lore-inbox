Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265642AbRGCI7z>; Tue, 3 Jul 2001 04:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbRGCI7p>; Tue, 3 Jul 2001 04:59:45 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:269 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265642AbRGCI7e>;
	Tue, 3 Jul 2001 04:59:34 -0400
Date: Tue, 3 Jul 2001 18:42:31 +1000
To: Android <android@abac.com>
Cc: Christopher Yeoh <cyeoh@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more penguins
Message-ID: <20010703184231.A7057@krispykreme>
In-Reply-To: <5.1.0.14.2.20010703082546.01c5eae0@mail.abac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20010703082546.01c5eae0@mail.abac.com>
User-Agent: Mutt/1.3.18i
From: anton@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What is the point of displaying penguins in framebuffer mode if it is going
> to change the video mode set by the vga= command line parameter?
> I like to set my display to 50 lines. This won't stay when the penguin 
> comes up.
> In standard character mode, this isn't a problem. So, how do we fix this?
> Is there a command line parameter that prevents the penguin logo from 
> coming up?

Just change VTs or "echo ^[c" to the screen to clear the boot logo.

Anton
