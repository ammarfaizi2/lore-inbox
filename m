Return-Path: <linux-kernel-owner+w=401wt.eu-S1161079AbXAEMEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbXAEMEv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbXAEMEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:04:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:38804 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161079AbXAEMEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:04:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=deyUaOsPnkH6sAgOfIlVofvlZaNPrN83KfvhDGVX3QEYi8RI6hO/TztXq85VvzhU4FPvF7w2/iZagU1k7hGTr4o/fUEbFWwmqWkYd77EraAjhCmo/6SY7LXptpI+vyV54UL6v/XugvYFn+PFpfBOeNFdaedZnIdPb9t6Xq8BKUo=
Message-ID: <8355959a0701050404t46ff7c56i52737051b8725c74@mail.gmail.com>
Date: Fri, 5 Jan 2007 17:34:48 +0530
From: Akula2 <akula2.shark@gmail.com>
To: "Auke Kok" <sofar@foo-projects.org>
Subject: Re: Multi kernel tree support on the same distro?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <459DFE9F.9050904@foo-projects.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
	 <459D9872.8090603@foo-projects.org>
	 <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
	 <459DFE9F.9050904@foo-projects.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/07, Auke Kok <sofar@foo-projects.org> wrote:
> Steve Brueggeman wrote:
Thanks Steve for your inputs.

> gcc 3.4.x works great on both 2.6 and 2.4, no issues whatsoever.

Do you mean I need to discard gcc 4.1.x on the distro? Or keep both?


> Most binary distro's won't support this, but I think all of the source distro's and more
> specific ones support it and a few handle it out of the box.

Hmm. How to solve this? Build a distro from scratch?  Which distro you suggest?
I do have Fedora based custom distro experience (right from the
ripping of Anaconda to X building, etc).

> Cheers,
>
> Auke
>
~Akula2
