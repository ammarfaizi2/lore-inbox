Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUJWXfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUJWXfw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUJWXfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:35:52 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:3435 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261159AbUJWXfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:35:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oCLZhiyqem7UUauOpz7kQ7YKqX1cCRNKUbeFryjSiy7MQcia2LsTx1ex59zEBz9GUNvGkxj/PBDeiiY7UwPeVHur7E5tmy6vfrXRtfz/i04vSz0SeX5saNM8OzpAHR3v26KBkejO76cfqm3mLkuqbX3Ve0EjRI0vAPMfiGuLwNU=
Message-ID: <35fb2e590410231635616f10c9@mail.gmail.com>
Date: Sun, 24 Oct 2004 00:35:46 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: How is user space notified of CPU speed changes?
Cc: Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098566366.24804.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
	 <1098566366.24804.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 22:19:28 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> - It doesn't handle split CPU speed SMP - where CPU speeds vary

Alan,

Out of sheer interest, you said you had an example box which did this.
I've never actually seen a modern SMP setup with different cock
frequencies (even accepting it's possible) - can you give me a more
modern example? I'm sure they're out there, I've just missed it, and I
have to confess to not being aware that Linux supported this kind of
setup.

Cheers,

Jon.
