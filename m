Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313559AbSD3No7>; Tue, 30 Apr 2002 09:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSD3No6>; Tue, 30 Apr 2002 09:44:58 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:21770 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313559AbSD3No5>;
	Tue, 30 Apr 2002 09:44:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: The tainted message 
In-Reply-To: Your message of "Tue, 30 Apr 2002 23:37:32 +1000."
             <20020430133732.GB22705@higherplane.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Apr 2002 23:44:48 +1000
Message-ID: <9728.1020174288@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2002 23:37:32 +1000, 
john slee <indigoid@higherplane.net> wrote:
>how about adding an optional tag to modules for a support/faq URL?

It is already there!

MODULE_LICENSE("Proprietary FOO P/L - contact someone@somewhere for support");

insmod prints the license text.

