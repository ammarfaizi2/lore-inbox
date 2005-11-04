Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbVKDPRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbVKDPRM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVKDPRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:17:12 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:64005 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964937AbVKDPRK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:17:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XO2Ch8oj7iiuIR7FfG4Azr3CDJIrKXilHujogeLo09B7bk1IQ7yVIeUzMWIWdHgqMFCsZ4u58GvtKfiQ0t426jBIhcuUeG1uhbRIF3exyv+10W1UJI0BAMDfgOQpEX7R9nJOZ1RzGjZoDsqtNaVrHzGZmJff9GaP/bbL4iL/tNg=
Message-ID: <cb2ad8b50511040717k61bb560dsbe31a5c25f394bba@mail.gmail.com>
Date: Fri, 4 Nov 2005 10:17:09 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Trevor Woerner <twoerner.k@gmail.com>
Subject: Re: latency report
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <569d37b00511032306y27519a8am69f2385fdbd4b81f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <569d37b00511032306y27519a8am69f2385fdbd4b81f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Trevor Woerner <twoerner.k@gmail.com> wrote:
>
> My report currently compares the stock kernel.org 2.6.14 with Ingo's
> 2.6.14-rt2 patches on two target boards.
>

Trevor,

rt2 was seriously screwed up (I posted about the problems in here).
rt3 solved the problems. You might want to repeat your testing with at
least rt3.

Carlos

--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
