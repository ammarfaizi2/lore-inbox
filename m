Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWDKTlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWDKTlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWDKTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:41:36 -0400
Received: from wproxy.gmail.com ([64.233.184.231]:65314 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750824AbWDKTlg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:41:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ntcdUI6FS1rBukJnpf9Zo4B5SoZqUA7Eu5xkV1yi5FTRHQUnqIIFDeKV2ErIogM19O1UCq3S3Ysk4gSKvXLmV6TpVYqUR7Rctl3TyMDOkYMYp1DKyHxKOpzeLnpEf4TUvOhJgV8FsCngaoq6iZgSG8baMN6kHUZigThUZooBnrw=
Message-ID: <7c3341450604111241h1c20ae11qce4599f7ba8c07c2@mail.gmail.com>
Date: Tue, 11 Apr 2006 20:41:34 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "Paolo Ornati" <ornati@fastwebnet.it>
Subject: Re: what does 2.6.16.3 patch against?
Cc: "John Tate" <kintaro@aanet.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20060411144737.277ced53@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1144756073.3475.2.camel@localhost.localdomain>
	 <20060411144501.5ae1bea2@localhost>
	 <20060411144737.277ced53@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/06, Paolo Ornati <ornati@fastwebnet.it> wrote:
> On Tue, 11 Apr 2006 14:45:01 +0200
> Paolo Ornati <ornati@fastwebnet.it> wrote:
>
> > Documentation/applying-patches.txt
>
> And if you don't want to apply patches manually there's always ketchup:
>
> http://www.selenic.com/ketchup/wiki/

I have seen this before posted here... and after I got my head around
it, WOW.  What a good tool (if it works right, building right now ;-) 
)

It took me some sussing to upgrade from 2.6.15.4 -> 2.6.15.7 (I
trashed my 2.6.15.6 tree, so had to start from last full kernel source
I had), but once sorted it is so fast!

Good job :-)

Nick
