Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752189AbWCPGqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbWCPGqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbWCPGqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:46:36 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:40581 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752189AbWCPGqf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:46:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M4JQ92/bmGc1twtTPIhVyOn2G7husLdt8yQbUqjLldGieLH2Owy6D6RAtYvOvvPFDMrkfCVH4KC7nGNLpN7ENhA0jVmI/qmC1LoHBTahardSzvThNk8FnNHU60r7njUVAccDjgvxCOE+pQ82edQ1xGLTZlY5FkgY1kIwp8m6Ikc=
Message-ID: <38c09b90603152246yc168984j3921bfbd27b5d3ae@mail.gmail.com>
Date: Thu, 16 Mar 2006 14:46:34 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Lanslott Gish" <lanslott.gish@gmail.com>,
       "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>,
       "Greg KH" <greg@kroah.com>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
In-Reply-To: <20060315140800.GC32065@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
	 <200603112155.38984.daniel.ritz-ml@swissonline.ch>
	 <38c09b90603121701q69c61221lf92bb150e419b1c9@mail.gmail.com>
	 <38c09b90603131710p7932c12qf6e8602b9b0b59c8@mail.gmail.com>
	 <20060314103854.GC32065@lug-owl.de>
	 <38c09b90603142030o7092a39aq8ace7758972ce09a@mail.gmail.com>
	 <20060315140800.GC32065@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm not sure if any touch device need this.
If some need, please move any code to general part. thx.


On 3/15/06, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Wed, 2006-03-15 12:30:04 +0800, Lanslott Gish <lanslott.gish@gmail.com> wrote:
> > did you mean like that? thx.
>
> That's basically the same patch as before?! What was ment is to move
> inverting the axes into usbtouch_process_pkt().
>
> MfG, JBG
>
> --


--
L.G, Life's Good~
