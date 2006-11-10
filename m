Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946149AbWKJJVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946149AbWKJJVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946145AbWKJJVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:21:37 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:48097 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1946149AbWKJJVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:21:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k1J7GVAwMuBgeaE1cCO5QoI8GeAMXfk+IXyHVY8z7OaPWRvtzk5X1xQGRX7UNGvTyQ7VowES988VlqaLrB1NskcHTDA/Iyf/bmIcYFtnSTR9r022rbB1+0VYyBY6FpAeHroDy6NhoHMRrpOF7VAhoi4zDKU+NN1Ss7spiYnVqAY=
Message-ID: <b6a2187b0611100121k71874475hb082595fb7fbf72a@mail.gmail.com>
Date: Fri, 10 Nov 2006 17:21:35 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
Cc: "Adrian Bunk" <bunk@stusta.de>, "Matthew Wilcox" <matthew@wil.cx>,
       "Andi Kleen" <ak@suse.de>, "Aaron Durbin" <adurbin@google.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061109224356.729716fe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>
	 <200611080839.46670.ak@suse.de>
	 <20061108122237.GF27140@parisc-linux.org>
	 <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
	 <20061108172650.GC4729@stusta.de>
	 <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
	 <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
	 <Pine.LNX.4.64.0611081010120.3667@g5.osdl.org>
	 <b6a2187b0611092225m47378626oe62b0466d904abbd@mail.gmail.com>
	 <20061109224356.729716fe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 10 Nov 2006 14:25:30 +0800
> "Jeff Chua" <jeff.chua.linux@gmail.com> wrote:
>
> > On 11/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > > Pushed out. Jeff, can you verify that current git does the right thing.

Yes, this does it. It's working with MMCONFIG now.

Thank you!

Jeff.
