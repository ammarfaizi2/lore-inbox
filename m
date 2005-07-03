Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVGCUEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVGCUEC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 16:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVGCUEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 16:04:02 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:31138 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261514AbVGCUDy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 16:03:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NEMaszZVZXpkPY/Xu7RmzPBLm7MCeBZczMmOGa7eA/sHbqfMsiBPPn0phgqT8m7fZtn9UctbRow50ko0sLeXwiYh5VYUV/L6I/H4f9uq2XWMnm0SM4TuQ4XAWlG4UynMmrtVaOdHAlBgRYBf49SuOodTQ36tIkoM90zAegYvuao=
Message-ID: <9a87484905070313036c533bdd@mail.gmail.com>
Date: Sun, 3 Jul 2005 22:03:53 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Henrik Brix Andersen <brix@gentoo.org>
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Cc: Dave Hansen <dave@sr71.net>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       Yani Ioannou <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <1120419722.23835.21.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1119559367.20628.5.camel@mindpipe>
	 <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>
	 <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz>
	 <9a8748490507030407547fa29b@mail.gmail.com>
	 <42C82BBB.9090008@gmail.com> <1120418514.4351.6.camel@localhost>
	 <9a8748490507031242270cc89@mail.gmail.com>
	 <1120419722.23835.21.camel@sponge.fungus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/05, Henrik Brix Andersen <brix@gentoo.org> wrote:
> On Sun, 2005-07-03 at 21:42 +0200, Jesper Juhl wrote:
> > Henrik: Are you planning on doing more work on this?   I ask since it
> > seems we are duplicating effort atm.  I think we should instead pool
> > our resources and work on just one implementation (don't know if
> > you've seen mine, but it's in the lkml archives earlier in this
> > thread).
> 
> No need to duplicate effort.
> 
> > What are your plans? Got any suggestions on how we should proceed?
> > Personally I just want to end up with a working driver and I don't
> > care much if we use your work or mine as a starting point.
> 
> I'd love to be able to work on this driver, but unfortunately it seem
> IBM did not put any accelerometers in the X31, which is what I have
> available for testing.
> 
Ok, I'll carry this forward then. I see some good bits in your driver
and some good bits in mine. I'll merge the good bits from both and
carry on with that.

Thanks a lot for the work you did so far :-)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
