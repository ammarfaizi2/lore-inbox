Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285409AbRLGEsw>; Thu, 6 Dec 2001 23:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285414AbRLGEsm>; Thu, 6 Dec 2001 23:48:42 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:29433 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S285409AbRLGEsi>; Thu, 6 Dec 2001 23:48:38 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
        rusty@rustcorp.com.au, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Rik vav Riel <riel@conectiva.com.br>, lars.spam@nocrew.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        lkml <linux-kernel@vger.kernel.org>, jmerkey@timpanogas.org
Date: Thu, 6 Dec 2001 20:23:36 -0800 (PST)
Subject: Re: SMP/cc Cluster description
In-Reply-To: <20011206195650.A25735@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.40.0112062021260.3900-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Jeff V. Merkey wrote:

> On Thu, Dec 06, 2001 at 03:16:13PM -0800, David Lang wrote:
> > also some applications (i.e. databases) are such that nobody has really
> > been able to rewrite them into the shared nothing model (although oracle
> > has attempted it, from what I hear it has problems)
> >
> > David Lang
>
> OPS (Oracle Parallel Server) is shared nothing.
>

correct, and from what I have been hearing from my local database folks
it's significantly less efficiant then a large SMP machine (up intil you
hit the point where you just can't buy a machine big enough :-)

I'm interested in hearing more if you have had better experiances with it.

David Lang
