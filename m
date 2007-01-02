Return-Path: <linux-kernel-owner+w=401wt.eu-S1754747AbXABAiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbXABAiT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbXABAiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:38:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:41989 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbXABAiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:38:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M/n6iqC1BYna0Zb85mQ83YgOnUv8GqyIkj7t/VIcKWvjxETPWzziiaLcooRMDHk3CB5DqLnCrzA9To/3bdksIRGGRbO3LyggxP59P8D//3Yg5X2oR4F3KIh/g6s3QCKxPLbZ/Qg9FATB2/72Y8UJnQAyoy71qSj6iyJrKiQn7Ts=
Message-ID: <68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
Date: Tue, 2 Jan 2007 01:38:17 +0100
From: Luca <kronos.it@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: add support for newer cards
Cc: "Andrew Morton" <akpm@osdl.org>, "Solomon Peachy" <pizza@shaftnet.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <1167696853.23340.156.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070101212551.GA19598@dreamland.darkstar.lan>
	 <20070101214442.GA21950@dreamland.darkstar.lan>
	 <1167696853.23340.156.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Mon, 2007-01-01 at 22:44 +0100, Luca Tettamanti wrote:
> > Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto:
> > > Hi Ben, Andrew,
> > > I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> > > The patch adds support for newer Radeon cards and is mainly based on
> > > X.Org code.
> >
> > And - for an easier review - this is the diff between
> > radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> > changes not included).
>
> Ah good, what I was asking for :-) I'll try to get a new patch combining
> everything out asap.

Great, I didn't know you were working on this, I feared that the patch
had been forgotten.
I've a X850 (R480) here, feel free to send me any patch for testing.

Luca
