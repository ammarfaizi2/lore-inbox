Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWHHSgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWHHSgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHHSgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:36:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:46613 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751142AbWHHSgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:36:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=df0Yypv2vJUpACQ+8R0kkZs4CHw4lfY5jgjROt8omu290OZsBjKo2W8Qt25Clgjh50Zd2gsQq5KW1tD2shopqGa4LNqk5gUaQM3ZFkFrYu0V4193T5Dkfys3xwOqlGzJGW6IYJyWA2SxttaWovy7iTo5IS5KEIWgTAtAUhSDNC4=
Message-ID: <b637ec0b0608081136o3adf98dbn15e206c8eea41a1c@mail.gmail.com>
Date: Tue, 8 Aug 2006 20:36:19 +0200
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: 2.6.18-rc3-mm2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000608081124s53777b42v4bb4d48c90f6a59e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <b637ec0b0608071147kb8a191bka9d6afe5b5287d08@mail.gmail.com>
	 <d120d5000608071200k3eb2bfd6v166c6bc92f5dcadf@mail.gmail.com>
	 <200608081641.48621.rjw@sisk.pl>
	 <d120d5000608081042i46eca97fvf1c3d67db65731b9@mail.gmail.com>
	 <b637ec0b0608081116p3f39aacaq4b2e22142a405abb@mail.gmail.com>
	 <d120d5000608081124s53777b42v4bb4d48c90f6a59e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 8/8/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 8/8/06, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> > Hi Dmitry.
> >
> > On 8/8/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > > Fabio, do you have a multiplexing controller as well?
> >
> > Well, I don't even know what this means :-(
> > How do I know?
> >
> > However, it's a HP laptop, model name Pavillion DV4378EA.
> >
>
> Yep, you do have it:
>
> > i8042.c: Detected active multiplexing controller, rev 1.1.
>
> Could you please try booting with i8042.nomux and tell me if it works?
>

Yup, it works.

> Thanks!
>
> --
> Dmitry
>

Ciao.
Fabio
