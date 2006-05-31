Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWEaHN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWEaHN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 03:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWEaHN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 03:13:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:22883 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964853AbWEaHN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 03:13:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BPNqVRzfkrF6wes28IzJbEsppgDQwntnhi4WszlgH1X1JYLr+Ysam60zyx+Bk8NcGNZvR9kUwF+skkDo0ZFBOD11i7U/QRhD6edSljAD1zjbx+uvcp9laghcBKnQ7l+B4DNd6ra7pactG2ii886SieJbkog0btfA1UEtSmgGQlA=
Message-ID: <9e4733910605310013y22dfa6cah766047957ad2a3c0@mail.gmail.com>
Date: Wed, 31 May 2006 03:13:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Martin Mares" <mj@ucw.cz>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Ondrej Zajicek" <santiago@mail.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <mj+md-20060531.064701.10737.atrey@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
	 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
	 <20060530223513.GA32267@localhost.localdomain>
	 <9e4733910605301555o287cbd18i99c8813ca6592494@mail.gmail.com>
	 <mj+md-20060531.064701.10737.atrey@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/06, Martin Mares <mj@ucw.cz> wrote:
> > My thoughts are mixed on continuing to support text mode for anything
> > other than initial boot/install. Linux is all about multiple languages
> > and the character ROMs for text mode don't support all of these
> > languages.
>
> On most servers, you don't need (and you don't want) anything like that.
> In such cases, everything should be kept simple.

Not so simple if you only speak Chinese and are installing that server.

-- 
Jon Smirl
jonsmirl@gmail.com
