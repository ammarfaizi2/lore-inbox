Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129544AbRBSVcw>; Mon, 19 Feb 2001 16:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129452AbRBSVcm>; Mon, 19 Feb 2001 16:32:42 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:25357 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129338AbRBSVcb>;
	Mon, 19 Feb 2001 16:32:31 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@caldera.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Philipp Rumpf <prumpf@mandrakesoft.com>
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: Your message of "Mon, 19 Feb 2001 14:25:39 BST."
             <200102191325.OAA12026@ns.caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Feb 2001 08:32:23 +1100
Message-ID: <32524.982618343@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001 14:25:39 +0100, 
Christoph Hellwig <hch@caldera.de> wrote:
>You just reinvented the read-copy-update model
>(http://www.rdrop.com/users/paulmck/rclock/intro/rclock_intro.html)...
>
>The mail proposing that locking model for module unloading is not yet
>in the arvhices, sorry.

I did not reinvent it, I was following up on the discussion we already
had off list about using this model.

