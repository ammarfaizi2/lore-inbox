Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbULDXzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbULDXzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 18:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbULDXzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 18:55:20 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:2197 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261203AbULDXzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 18:55:16 -0500
Subject: Re: kernel development environment
From: Lee Revell <rlrevell@joe-job.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Alessandro Amici <alexamici@fastwebnet.it>,
       Miguel Angel Flores <maf@sombragris.com>, linux-kernel@vger.kernel.org
In-Reply-To: <41B24A46.2010802@osdl.org>
References: <41B1F97A.80803@sombragris.com>
	 <200412042121.49274.alexamici@fastwebnet.it>
	 <41B22381.10008@sombragris.com>
	 <200412042237.48729.alexamici@fastwebnet.it>
	 <1102196829.28776.46.camel@krustophenia.net>
	 <41B22EDE.2060009@stud.feec.vutbr.cz>
	 <1102200355.28776.58.camel@krustophenia.net>  <41B24A46.2010802@osdl.org>
Content-Type: text/plain
Date: Sat, 04 Dec 2004 18:55:13 -0500
Message-Id: <1102204514.28776.79.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-04 at 15:37 -0800, Randy.Dunlap wrote:
> Lee Revell wrote:
> > I still say it's broken.
> > 
> > http://lkml.org/lkml/2004/10/22/488
> 
> so don't use copy-paste.  that idea is broken.
> 

diff foo bar | xclip works perfectly with my mailer and does not require
a temporary file.  There is no good reason for this not to work in
mozilla.  Therefore it's a bug.

> otoh, netscape/mozilla/thunderbird mail
> all work fine (except that attachments are required,
> instead of being able to insert patches inline).
> 

I am aware that a workaround is available.  Doesn't mean it's not a bug.

Lee

