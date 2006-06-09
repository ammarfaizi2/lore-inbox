Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWFIS1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWFIS1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWFIS1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:27:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:29391 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWFIS1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:27:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C5zVb3Fumbjx63FrrVnH+Pr5K67ugjWqg5yaRAszo8YrTDI1Cp4qQ+CKHMx88XfQ16UG9p2mZVhT1KHRfv582GRfXoYXR+aYIYh4S0YapYXwfmGNRf0Mc6wJyPhuonNJzTx4dIjHwc6sujTXgzrKuNfN4YUpLMxGqRqs+FaMVO0=
Message-ID: <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com>
Date: Fri, 9 Jun 2006 14:27:53 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Cc: "Andrew Morton" <akpm@osdl.org>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <4489B719.2070707@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <20060609091327.GA3679@infradead.org>
	 <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org>
	 <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org>
	 <20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org>
	 <4489B719.2070707@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Jeff Garzik <jeff@garzik.org> wrote:
> Jeff Garzik wrote:
> > I disagree completely...  it would be an obvious win:  people who want
> > stability get that, people who want new features get that too.
>
> And developers have a better outlet for their wacky developmental urges...

And no real-world near-term progress is made for production users with
modern requirements. What you're advocating breeds instability in the
near-term.
