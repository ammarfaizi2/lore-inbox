Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVGCLIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVGCLIB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVGCLIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:08:00 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:48989 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261291AbVGCLHw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:07:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j8WmfNFXulierB1EZGdm70MLDz3drFztXfCbfMR0tHts0ko7oyCNvGRcoQCSNeKJVUdhqF9WAg24ibxynZ6texFWgdW5qEac3sqnRZF/hR+U+a3ZyC5ukh6LevKye/amg4s1YtesDtHyrivkFSf9jYwzNvQQs4QyPKVDhWULksw=
Message-ID: <9a8748490507030407547fa29b@mail.gmail.com>
Date: Sun, 3 Jul 2005 13:07:52 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       Yani Ioannou <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20050703101613.GA2372@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1119559367.20628.5.camel@mindpipe>
	 <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
	 <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
	 <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>
	 <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sun, Jul 03, 2005 at 03:37:06AM -0500, Alejandro Bonilla wrote:
> 
> > Guys,
> >
> >    We might have something here. If you are a driver writer, developer
> > or want to help us, this is when.
> >
> > PLEASE read the following article, it has the data of a guy that made a
> > driver in IBM for Linux and he described the driver he made. He cannot
> > release it, but he explained it and someone can write one. Believe me,
> > that I would do it, if I would have any knowledge. ;-)
> > http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
> 
> This should indeed be enough to write a Linux driver.
> 
I'll give it a shot. I've got the day off today so I'll try a simple
module and test it on my T42. I'll post whatever I come up with
tonight.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
