Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVE1VCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVE1VCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 17:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVE1VCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 17:02:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60050 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261157AbVE1VCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 17:02:54 -0400
Subject: Re: PATCH: "Ok" -> "OK" in messages
From: Lee Revell <rlrevell@joe-job.com>
To: cutaway@bellsouth.net
Cc: "Sean M. Burke" <sburke@cpan.org>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
In-Reply-To: <007001c56387$235672d0$2800000a@pc365dualp2>
References: <42985251.6030006@cpan.org>
	 <007001c56387$235672d0$2800000a@pc365dualp2>
Content-Type: text/plain
Date: Sat, 28 May 2005 17:02:53 -0400
Message-Id: <1117314173.5423.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-28 at 09:14 -0400, cutaway@bellsouth.net wrote:
> printk("The PukeMaster is %sabled.\n", SomeFlag ? "dis" : "en");
> 
> If a NLS translator isn't a C programmer, they'll screw it up frequently.

Then you need a better translator.

Lee

