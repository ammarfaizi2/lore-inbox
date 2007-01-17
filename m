Return-Path: <linux-kernel-owner+w=401wt.eu-S1752014AbXAQEZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbXAQEZX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXAQEZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:25:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:20277 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbXAQEZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:25:22 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SDTEV9mBBZUW/Bd8DdEv0vO4zRPQnZjv7uZyd1uYyCv3wmOAw3NpwsrJwzBKZFHIHoJqq4XJbEbWc3RPLKDpkLOvwCasmmxrXhAhDgS1vTkj8cagFnJQRupTbItVffcpdiM4rl2YadBnzGhCJ3FXvQmKYfAENV3znyNHe5neG2E=
Message-ID: <305c16960701162025o2f96eb25m79f58aede11821ec@mail.gmail.com>
Date: Wed, 17 Jan 2007 02:25:19 -0200
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: BUG: linux 2.6.19 unable to enable acpi
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1169007288.3457.4.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com>
	 <1169007288.3457.4.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/07, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2007-01-17 at 02:01 -0200, Matheus Izvekov wrote:
> > Just tried linux for the first time on this old machine, and i got
> > this problem. dmesg below:
>
>
> did this machine EVER support acpi ?
>
>

It used to support power button events, dont know what else. Is there
anything I can do to check how good the acpi support is?
