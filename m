Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbUKTFma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUKTFma (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUKTFm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 00:42:28 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:27805 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261774AbUKTFkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 00:40:23 -0500
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Torben Hohn <torbenh@informatik.uni-bremen.de>,
       Jody McIntyre <scjody@modernduck.com>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <87y8ha1wcb.fsf@sulphur.joq.us>
References: <87y8ha1wcb.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 22:55:01 -0500
Message-Id: <1100922902.1424.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 16:39 -0600, Jack O'Quin wrote:
> +#include <linux/module.h>
> +#include <linux/security.h>

These seem to be the only two includes that are needed.

Any other objections to the patch?

Lee

