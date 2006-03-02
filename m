Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWCBSSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWCBSSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWCBSSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:18:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:28340 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750976AbWCBSSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:18:11 -0500
From: Andi Kleen <ak@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Another compile problem with 2.6.15.5 on AMD64
Date: Thu, 2 Mar 2006 19:17:50 +0100
User-Agent: KMail/1.9.1
Cc: Steffen Weber <email@steffenweber.net>, linux-kernel@vger.kernel.org,
       Christoph Lameter <christoph@lameter.com>,
       J.E.J.Bottomley@hansenpartnership.com, stable@kernel.org
References: <44071AF3.1010400@steffenweber.net> <4407347F.1000209@steffenweber.net> <200603021916.50053.jesper.juhl@gmail.com>
In-Reply-To: <200603021916.50053.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021917.52268.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 19:16, Jesper Juhl wrote:

> Andi, Christoph : would this make sense as a fix for -stable ?

It's already fixed in stable.

> How about mainline ?

mainline never had this problem. The backport was just bad.

-Andi
