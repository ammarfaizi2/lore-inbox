Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966280AbWKYI5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966280AbWKYI5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934495AbWKYI5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:57:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17128 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S934514AbWKYI5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:57:16 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86-64: change the size for interrupt array to NR_VECTORS
References: <86802c440611241736l545ddf33i3bb08f3cd6446b14@mail.gmail.com>
	<m1psbcovwv.fsf@ebiederm.dsl.xmission.com>
	<86802c440611250040t6c18272et495dd72e2eda7d7a@mail.gmail.com>
Date: Sat, 25 Nov 2006 01:55:12 -0700
In-Reply-To: <86802c440611250040t6c18272et495dd72e2eda7d7a@mail.gmail.com>
	(Yinghai Lu's message of "Sat, 25 Nov 2006 00:40:45 -0800")
Message-ID: <m1zmafoqhb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> On 11/24/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> "Yinghai Lu" <yinghai.lu@amd.com> writes:
>> YH.  Please place a newline between your subject and your description
>> in the body of your patches.
>
> Next time.
>
>> Yep I missed this optimization opportunity :)
>
> You did a great job to clean up the irq_vector mapping.

Yep and created many new optimization and clean up opportunities...
Because I didn't take everything to it's full logical conclusion :)

Just enough to make everything architecture specific.

Eric

