Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWEQNqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWEQNqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWEQNqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:46:32 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:59540 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932554AbWEQNqb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:46:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rADtVaJaMPVgGunSMPdf6pphJ/MEqT778W2IwKeVLduH9madAzg+Jvkh8ItPchKjiAd/JVHDnMnt3ceXbyjLqbwHmks40Cw2U8eww5Ea3LVZ6uEagIOWux4Kpqi/2gE9dc+rr/rbGeFcteSmchm+WrGNbGOcj2NHvDzMasRF53c=
Message-ID: <b6c5339f0605170646ya421b70w9354544b3390e74b@mail.gmail.com>
Date: Wed, 17 May 2006 09:46:30 -0400
From: "Bob Copeland" <me@bobcopeland.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: replacing X Window System !
Cc: "linux cbon" <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060517132403.GB23933@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605171218.k4HCIt4L013978@turing-police.cc.vt.edu>
	 <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
	 <20060517132403.GB23933@csclub.uwaterloo.ca>
X-Google-Sender-Auth: 26d41cdfbcd2637c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Wed, May 17, 2006 at 02:39:37PM +0200, linux cbon wrote:
> > If we have a new window system, shall all applications
> > be rewritten ?
>
> Unless you make your new system compatible with X, then all X
> applications must be rewritten.

True for things written directly with Xlib, but hardly anything new is
written without a toolkit these days.  E.g. someone could port GDK to
the new windowing system of the week and all GTK+ applications would
work.  Though I won't disagree that the idea is pointless.

Bob
