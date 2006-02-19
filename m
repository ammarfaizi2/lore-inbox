Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWBSVap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWBSVap (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWBSVap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:30:45 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:35515 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932278AbWBSVan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:30:43 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       Pavel Machek <pavel@suse.cz>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060219205157.GA5976@us.ibm.com>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
	 <7c3341450602190318o1c60e9b5w@mail.gmail.com>
	 <20060219205157.GA5976@us.ibm.com>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 16:30:37 -0500
Message-Id: <1140384638.2733.389.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 12:51 -0800, Nishanth Aravamudan wrote:
> I run Ubuntu Breezy, which has:
> 
> alsa-utils = 1.0.9a-4ubuntu5 

The alsa-utils version should not matter, it's alsa-lib that must be
kept in sync with the ALSA version in the kernel.

Lee

