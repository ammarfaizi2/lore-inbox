Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVI2Cgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVI2Cgk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 22:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVI2Cgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 22:36:40 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:49266 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751198AbVI2Cgk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 22:36:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kv8uQdYx6U34hK1sFpOd7qG2sCdoMuw/HpEf2Hz1GkWpDMTH5npfq/1OzcmybSV/ylI2FQjbmYouxLbPiZh+ZGZy5mA8Xz/vSnBqj/HxtThcDO63B3ZW6nO9jXDeXvNjH1XIDBdvKkTaYhe1m/QJ5VRDTbTApNj0jZYjEDjQV1s=
Message-ID: <9a874849050928193667653c33@mail.gmail.com>
Date: Thu, 29 Sep 2005 04:36:39 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>
Subject: Re: [RFC][patch 2.6.14-rc2] dell_rbu: Changing packet update mechanism
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <597A2BC19EDD3C458F841E8724E92D4B973E26@ausx3mps301.aus.amer.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <597A2BC19EDD3C458F841E8724E92D4B973E26@ausx3mps301.aus.amer.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Abhay_Salunke@dell.com <Abhay_Salunke@dell.com> wrote:
>
>
> -----Original Message-----
> From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> Sent: Wednesday, September 28, 2005 7:01 PM
> To: Salunke, Abhay
> Cc: linux-kernel@vger.kernel.org; akpm@osdl.org
> Subject: Re: [RFC][patch 2.6.14-rc2] dell_rbu: Changing packet update
> mechanism
>
> On Friday 23 September 2005 21:40, Abhay Salunke wrote:
> > Please ignore earlier patches as there was error submitting it! :-(
> > patch below is good...
> >
>
> Ok, I'm being pedantic. So shoot me.
> There are a few tiny bits CodingStyle wise that could be better. No big
> deal, I'm nitpicking in the extreme here...
>
> All of this code was ran thourgh Lindent!.

Lindent is not a panacea. It also matters what
Documentation/CodingStyle spells out and what is common practice in
other parts of the kernel.


> BTW there is a new patch which might have covered your concers.
>
Got a reference/link?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
