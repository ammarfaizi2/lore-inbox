Return-Path: <linux-kernel-owner+w=401wt.eu-S932796AbWLSLyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbWLSLyM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932800AbWLSLyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:54:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:28849 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932796AbWLSLyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:54:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NGczWSVu9x10hBV6ldzMGtbDLZOPsqiEU6vO1C+uFgrA2YZgdI99uAVAvmXdZ6eRUUAu0JYKS7C4s6FWNcBZWN65G9/7ngHebuOIGDDoeKLCpjQGAJE2CLsDhptULt35woATws1TMDPV4e2kJPbFxsJ0ajwcHWZkTaaMfeqwLnE=
Message-ID: <625fc13d0612190354k1cf49fejc6e8165d6832321f@mail.gmail.com>
Date: Tue, 19 Dec 2006 05:54:09 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: linus' git repo down?
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612190154130.15178@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612190154130.15178@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
>
>   for the last couple of days, i've been unable to pull from linus'
> 2.6 repository.  i consistently get:
>
> $ git pull
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> No changes.
>
> even after several retries.  i can clone it from scratch, i just can't
> update from it.  thoughts?

git pull git://www2.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

zeus1 has been hammered lately.  zeus2 is basically just sitting idle.

josh
