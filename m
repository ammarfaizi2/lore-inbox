Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVFVAKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVFVAKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVFVAJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:09:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:1981 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262376AbVFVAF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:05:58 -0400
Subject: Re: [PATCH] more signed char cleanups in scripts
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
In-Reply-To: <20050621151806.07ef0f78.akpm@osdl.org>
References: <20050619233029.45dd66b8.akpm@osdl.org>
	 <1119391748l.25237l.3l@werewolf.able.es>
	 <20050621151806.07ef0f78.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 20:05:54 -0400
Message-Id: <1119398755.9814.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 15:18 -0700, Andrew Morton wrote:
> Remind me: what's the point in these changes?

They silence gcc 4.0 warnings.

Lee

