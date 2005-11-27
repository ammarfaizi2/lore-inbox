Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVK0B4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVK0B4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVK0B4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:56:11 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:31818 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbVK0B4L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:56:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YvIUj46H7iRBeSyz1gKlb4ZVZuR6DB64ytCdAvnvBFnNPuEJcglDizHTjCSI4XHEKSXsHYvn12mE7wf5krM4kgVuXIMIb0kEH1z4DwLIjCdats+0wKvK4M+lxI/doaEuwoDRuSFbILVoxhSibVyB1DUL5f9tgTSwr9YbgAjyd+o=
Message-ID: <9c21eeae0511261756r65d0f4b7l96b0e1089c4c62bc@mail.gmail.com>
Date: Sat, 26 Nov 2005 17:56:10 -0800
From: David Brown <dmlb2000@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200511270151.21632.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511270138.25769.s0348365@sms.ed.ac.uk>
	 <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
	 <200511270151.21632.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks Nish, this is obviously the difference. I never compile anything as
> root (pesky Makefiles rm -rf'ing things!).

Yeah, but you still need to install stuff as root... unless you do
weird stuff like installwatch or something.

- David Brown
