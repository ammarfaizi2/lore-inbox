Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425215AbWLHIx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425215AbWLHIx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 03:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425218AbWLHIx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 03:53:56 -0500
Received: from hu-out-0506.google.com ([72.14.214.228]:24387 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425216AbWLHIxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 03:53:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CTMVmW4EFSTPKA0FPSA6AQrB4SWTF2AvYkjM7rrpCnQBbiNpO19UYufb4Anf+dwLfn5yV2UmEG+44XBZNYfDY3/wmdOdHioZstfanv9X1fSdquqgx4cRqfM9wbNvUgSM/IX2O9l+Pk7iB3R8oFCFah35yTlCvBr6k5ZqsOAueL8=
Message-ID: <86802c440612080053s13e5318eq7ae83aff4c7eb21c@mail.gmail.com>
Date: Fri, 8 Dec 2006 00:53:53 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
Cc: "Greg KH" <gregkh@suse.de>, "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
In-Reply-To: <m17ix24ywj.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
	 <m17ix24ywj.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: d39b018b35ede3b2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Ugh.  I'd check the code.  But it looks like my tweak to the
> early fixmap code.  But my hunch is that my tweak to __fixmap
> so that it's pud and pmd were prepopulated didn't take on
> your build.

I missed some options?

YH
