Return-Path: <linux-kernel-owner+w=401wt.eu-S1751425AbXAKTMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXAKTMf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbXAKTMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:12:34 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:27501 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbXAKTMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:12:32 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gtCmINB3hy09o5PwGMpWToJ6VxH+xniJZ7UkWJ8pnWL/gzhkMjLFhrGy3xBam2Yn/rEXHKZ2saestTO71qlfyW5giXR1GpE2aQFX2EhuWTl/5Q51fteGApj6nCj92SIa9mHx6bQtOE9RqcPycnN0iL7VP+ANK5vDwnMzuDX6tYE=
Message-ID: <13426df10701111112r98598ddle9151230267be4d4@mail.gmail.com>
Date: Thu, 11 Jan 2007 12:12:30 -0700
From: "ron minnich" <rminnich@gmail.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Cc: "Stefan Reinauer" <stepan@coresystems.de>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       "OLPC Developer's List" <devel@laptop.org>,
       "Mitch Bradley" <wmb@firmworks.com>
In-Reply-To: <e31af5463dc2a8d051b632f54e65decf@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com>
	 <20070111182041.GA6243@coresystems.de>
	 <e31af5463dc2a8d051b632f54e65decf@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:

> Depends.  The kernel _can_ shut down OF; in that case, it
> becomes responsible for passing the device tree along to
> the kexec'd kernel.
>

so we will need the non-callback support anyway, it seems?

thanks

ron
