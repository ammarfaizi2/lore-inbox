Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281391AbRKEWO5>; Mon, 5 Nov 2001 17:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKEWOs>; Mon, 5 Nov 2001 17:14:48 -0500
Received: from zero.tech9.net ([209.61.188.187]:11279 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281391AbRKEWOk>;
	Mon, 5 Nov 2001 17:14:40 -0500
Subject: Re: [PATCH]agp for i820 chipset
From: Robert Love <rml@tech9.net>
To: Robert Love <rml@tech9.net>
Cc: Nicolas Aspert <Nicolas.Aspert@epfl.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1004991553.806.19.camel@phantasy>
In-Reply-To: <3BE6B50A.5010806@epfl.ch> <1004976089.934.12.camel@phantasy> 
	<3BE6D469.8000407@epfl.ch>  <1004991553.806.19.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 05 Nov 2001 17:14:41 -0500
Message-Id: <1004998482.2277.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 15:19, Robert Love wrote:

> Ohh, I didn't notice this.  It is odd the two sizes don't match.  If
> they really are different then I agree; don't use the generic one.

Hm, one thing to add is if other Intel chipsets have varying APSIZE
values, and this is all they differ by, and one has an APSIZE of 8bits,
then you can cheat and just point to that function.

	Robert Love

