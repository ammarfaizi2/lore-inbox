Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268175AbUJOQvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268175AbUJOQvh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUJOQvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:51:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:43992 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268175AbUJOQvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:51:31 -0400
Subject: Re: 2.6.9-rc4-mm1
From: Lee Revell <rlrevell@joe-job.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Christian Borntraeger <linux-kernel@borntraeger.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097824096l.5962l.0l@werewolf.able.es>
References: <20041011032502.299dc88d.akpm@osdl.org>
	 <416E03CD.8080701@jp.fujitsu.com> <20041013215049.7ccd73ae.akpm@osdl.org>
	 <200410141950.12199.linux-kernel@borntraeger.net>
	 <1097824096l.5962l.0l@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1097858824.4904.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 12:47:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 03:08, J.A. Magallon wrote:
> > There is another problem that "cat diff-file + X copy and paste" does 
> > convert all tabs as well. 
> > 
> 
> At least Balsa has an 'Include file...' menu entry besides the usual
> 'Attach file...', which does the right thing (TM).

For people who like "diff foo bar + X copy and paste", "diff foo bar |
xclip" then pasting into a non-broken mail client like Evolution will do
the right thing.

Lee

