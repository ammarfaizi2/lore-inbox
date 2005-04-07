Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVDGIFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVDGIFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVDGIFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:05:44 -0400
Received: from poseidon.uni-ak.ac.at ([193.170.188.104]:48073 "EHLO
	poseidon.uni-ak.ac.at") by vger.kernel.org with ESMTP
	id S262168AbVDGIFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:05:38 -0400
From: David Schmitt <david@black.co.at>
To: debian-kernel@lists.debian.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Date: Thu, 7 Apr 2005 10:04:32 +0200
User-Agent: KMail/1.7.2
Cc: Jes Sorensen <jes@wildopensource.com>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk
References: <20050404100929.GA23921@pegasos> <20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk> <yq08y3vxd3x.fsf@jaguar.mkp.net>
In-Reply-To: <yq08y3vxd3x.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071004.32692@zion.black.co.at>
X-test-SpamScore: /
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 April 2005 09:25, Jes Sorensen wrote:
> [snip] I got it from Alteon
> under a written agreement stating I could distribute the image under
> the GPL. Since the firmware is simply data to Linux, hence keeping it
> under the GPL should be just fine.

Then I would like to exercise my right under the GPL to aquire the source code 
for the firmware (and the required compilers, starting with genfw.c which is 
mentioned in acenic_firmware.h) since - as far as I know - firmware is coded 
today in VHDL, C or some assembler and the days of hexcoding are long gone.



Regards, David
