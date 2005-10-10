Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVJJJ2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVJJJ2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 05:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVJJJ2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 05:28:54 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:9132 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750716AbVJJJ2y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 05:28:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qgFlTUebBIyo3z7iuH8XB39nJwxKFUr9R+yxVeSnJmcEj1bAiQKkknc9OQDj80DzcMbibLptodJ5Fv4XtRCH/mSaB/sQ5yKQItvR7uUYlt6ilxQCl3iHgKcyl/C0Xabb9e/+juiqOxX49hfwJOwvocRpVyVgQiPUAlf4Fx5FB/4=
Message-ID: <309a667c0510100228s5c9bac7cwaf74548520bba808@mail.gmail.com>
Date: Mon, 10 Oct 2005 14:58:53 +0530
From: Devesh Sharma <devesh28@gmail.com>
Reply-To: Devesh Sharma <devesh28@gmail.com>
To: linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: Issues in Booting kernel 2.6.13
In-Reply-To: <309a667c0510100215wcf311bcr3cc0555cc4557d39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <309a667c0510052216n784e229ei69b3a3a2a9e93f4b@mail.gmail.com>
	 <20051006190806.388289ff.rdunlap@xenotime.net>
	 <43481D0F.9020407@dolphinics.no>
	 <20051008123131.41d85d45.rdunlap@xenotime.net>
	 <434A23A2.1020407@dolphinics.no>
	 <309a667c0510100215wcf311bcr3cc0555cc4557d39@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Randy, Simen and list
I am sorry , I could not reply ur post on 6th oct as I  have noticed
ur reply today. But I have got the solution for this.

During make menuconfig I forgot to include MPT FUSION device support
in my erlier compilation. But Now this is working fine

I am sorry If this has created any confusion among the list.
Or If its really an issue then let me know also.

Thanks
