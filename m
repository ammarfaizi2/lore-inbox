Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbVL2TUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVL2TUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVL2TUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:20:38 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:41891 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750900AbVL2TUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:20:37 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: Lee Revell <rlrevell@joe-job.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <200512291901.jBTJ1rOm017519@laptop11.inf.utfsm.cl>
References: <200512291901.jBTJ1rOm017519@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 14:26:24 -0500
Message-Id: <1135884385.6804.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 16:01 -0300, Horst von Brand wrote:
> >   - Someone asked for the kernel's i2c infrastructure to be used,but
> >     our i2c usage is very specialised, and it would be more of a mess
> >     to use the kernel's
> 
> Problem with that is that if everybody and Aunt Tillie does the same,
> the kernel as a whole gets to be a mess. 

ALSA does the exact same thing for the exact same reason.  Maybe an
indication that the kernel's i2c layer is too heavy?

Lee

