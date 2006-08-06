Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWHFJ4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWHFJ4q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 05:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWHFJ4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 05:56:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:25648 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751341AbWHFJ4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 05:56:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uAGBeLdGndI6rbRclbaj5vEkQh+5+2f5NWba31fuHkgryFT0V9q5vKujyjMZ8v67XcD3uJTD1fnh1Z3hUEIuMB5YOOnYaqcFK7dELK9BQwtF0aCV+ZxOYYH9RpuzQCELLp9LcXoO7tl95xH9o3fMcYrZPOldgOtX6JKfBBHn+70=
Message-ID: <41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com>
Date: Sun, 6 Aug 2006 12:56:43 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Cc: rlove@rlove.org, khali@linux-fr.org, gregkh@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060806005613.01c5a56a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492242899-git-send-email-multinymous@gmail.com>
	 <20060806005613.01c5a56a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 8/6/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 06 Aug 2006 10:26:46 +0300
> Shem Multinymous <multinymous@gmail.com> wrote:
>
> > Signed-off-by: Shem Multinymous <multinymous@gmail.com>
>
> This rather defeats the purpose of the DCO.

SubmittingPatches declares the purpose of the DCO as "To improve
tracking of who did what, especially with patches that can percolate
to their final resting place in the kernel through several layers of
maintainers."

I indeed certify  that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

Practically speaking, this contact address is stable and reliable.

What more is needed that may be realistically expected from a kernel
patch submission?

  Shem
