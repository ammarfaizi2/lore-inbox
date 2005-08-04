Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVHDUbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVHDUbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVHDUbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:31:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:26765 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262644AbVHDUbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:31:19 -0400
Subject: Re: Oops when shutting down laptop
From: Lee Revell <rlrevell@joe-job.com>
To: Kristian =?ISO-8859-1?Q?Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1123186901.8831.42.camel@localhost.localdomain>
References: <1123186901.8831.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 04 Aug 2005 16:31:14 -0400
Message-Id: <1123187474.3646.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 22:21 +0200, Kristian Grønfeldt Sørensen wrote:
> My laptop oops'es in the final phase of shutdown

Kernel is tainted due to ndiswrapper being loaded.  Please reproduce
with a non tainted kernel.

Lee

