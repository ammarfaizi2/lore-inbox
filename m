Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293338AbSCEPHG>; Tue, 5 Mar 2002 10:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293301AbSCEPHA>; Tue, 5 Mar 2002 10:07:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17794 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293314AbSCEPGX> convert rfc822-to-8bit;
	Tue, 5 Mar 2002 10:06:23 -0500
Date: Tue, 05 Mar 2002 07:04:14 -0800 (PST)
Message-Id: <20020305.070414.77058889.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020305153025.A12473@stud.ntnu.no>
In-Reply-To: <20020305.060323.99455532.davem@redhat.com>
	<20020305.060604.68157839.davem@redhat.com>
	<20020305153025.A12473@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Tue, 5 Mar 2002 15:30:25 +0100
   
   Hmm, I found a document through google; Cisco Catalyst 4006 doesn't support
   9KB MTUs, so I'll contact the networking guys and fix this, we want switches
   that supports large MTUs :)

It's not a reasonable request, it doesn't interoperate at all
with 10/100 segments, see my other mail.
