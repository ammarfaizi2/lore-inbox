Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965377AbWJBTbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965377AbWJBTbx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965378AbWJBTbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:31:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:50777 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965377AbWJBTbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:31:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wn0Bl4BQYTF/5mqIo1tNJhqEKf8Ft+dnrxdMoyj63Ov2AxpTHvn24nUx+HFByccNifAFornT4bQka+wwHq0oGAnbKkidTncnUryyzLQ0hadqjEwX0xewGmOlUpeA9LNRa+LGhzHBIjvV8cCP0yLbHcWTpjdbAi5QrgOD0JE4Omc=
Message-ID: <69304d110610021231m630ade47n6d52c1aadae43644@mail.gmail.com>
Date: Mon, 2 Oct 2006 21:31:51 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>, Valdis.Kletnieks@vt.edu,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
In-Reply-To: <Pine.LNX.4.64.0610021129150.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1159539793.7086.91.camel@mindpipe>
	 <20061002100302.GS16047@mea-ext.zmailer.org>
	 <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org>
	 <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org>
	 <1159811392.8907.36.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
	 <200610021822.k92IMo44008167@turing-police.cc.vt.edu>
	 <Pine.LNX.4.64.0610021129150.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 2 Oct 2006, Valdis.Kletnieks@vt.edu wrote:
> >
> > How did OSDL's MX checking deal with split in/out configurations like ours,
> > where our MX points at a load-balanced farm of Mirapoint front end appliances
> > with 1 IP address, but our main off-campus *outbound* comes from a different
> > address?
>
> Hey, if I knew what I was doing, I'd be in MIS.
>

I'd rather say you are not in MIS exactly because you prefer knowing
what you are doing.

> As it is, I just criticise other peoples patches.
>
>                 Linus

-- 
Greetz, Antonio Vargas aka winden of network

Every day, every year
you have to work
you have to study
you have to scene.
