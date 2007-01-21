Return-Path: <linux-kernel-owner+w=401wt.eu-S1751129AbXAUREY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbXAUREY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 12:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXAUREY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 12:04:24 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:8543 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbXAUREX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 12:04:23 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iY6C5lsbN/2KRVJuPv+rJXnISDAkUyR3PoyUbf6+7LbDLSO/rZJu+ol+jrQZEZWsRcW9oNQZumTP8kEQB73n27+/9TwOYjepPe1KKfIv7zTcJo0JUY9A8qm0gTChIh5lmAbgpd/CP0pGdnJFpEAa+8/MRQWLewgM4hHunYtQKa4=
Message-ID: <c384c5ea0701210904t15f44178hfd807b4553e0e3d3@mail.gmail.com>
Date: Sun, 21 Jan 2007 18:04:22 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c384c5ea0701201007t4e637b9eh133101286ce5598d@mail.gmail.com>
	 <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On 1/20/07, David Schwartz <davids@webmaster.com> wrote:
> [Leon said:]
> > One way of getting rid of those inconsistencies would be to follow IEC
> > 60027-2 for those cases where SI is inappropriate.
>
>         Talk about a cure worse than the disease! So you're saying that 256MB flash
> cards could be advertised as having 268.4MB? A 512MB RAM stick is
> mislabelled and could correctly say 536.8MB? That's just plain craziness.
>
No, I meant to advertise it as a 256 MiB flash device and a 512 MiB
flash device, as the Mi prefix has a single interpretation, that is 2
to the power of 20, as per IEC 60027-2, whereas M has not if used
outside SI units.

Leon.
