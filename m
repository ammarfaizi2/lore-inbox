Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946305AbWJSSaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946305AbWJSSaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946315AbWJSSaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:30:35 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:40971 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1946305AbWJSSae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:30:34 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: jt@hpl.hp.com
Subject: Re: 2.6.19-rc2-mm1 // errors in verify_redzone_free()
Date: Thu, 19 Oct 2006 20:31:09 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
References: <20061016230645.fed53c5b.akpm@osdl.org> <20061019102529.dea90fec.akpm@osdl.org> <20061019174728.GA9435@bougret.hpl.hp.com>
In-Reply-To: <20061019174728.GA9435@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610192031.09451.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> 	It's the same bug as before.
> 	The user is *not* using 2.6.19-rc2-mm1, but 2.6.19-rc2 :

Hmmm ... weird. I did fetch -mm1 with git like this:

git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.19-rc2-mm1

then make oldconfig && make && ... Will investigate. Sorry for the noise then.

	Mariusz Kozlowski
