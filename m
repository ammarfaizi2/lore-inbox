Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVGTRlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVGTRlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 13:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVGTRlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 13:41:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15551 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261414AbVGTRlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 13:41:08 -0400
Subject: Re: [new] kernel-desktop 2.6.12-1.1398_FC4.desktop_1
From: Lee Revell <rlrevell@joe-job.com>
To: Jean-Eric Cuendet <jec@rptec.ch>
Cc: fedora-list@redhat.com, freshrpms-list@freshrpms.net,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       David Goetschmann <dgo@rptec.ch>, jmsunseri@gmail.com, bcs@metacon.ca,
       ling@caltech.edu, posti@tomihalonen.com, killers_soul@hotmail.com,
       bhb@iceburg.net, mike.savage@gmail.com
In-Reply-To: <42DE6DBD.2030902@rptec.ch>
References: <42DE6DBD.2030902@rptec.ch>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 13:41:06 -0400
Message-Id: <1121881266.23806.34.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-20 at 17:29 +0200, Jean-Eric Cuendet wrote:
> Hi,
> I just released a new version of kernel-desktop. New features are:

> - Realtime LSM module (Useful for jack audio server)

2.6.12 supports RLIMIT_RTPRIO and RLIMIT_NICE so this is no longer
needed.

The distros need to get with the program, AFAIK none of them have even
released updated pam, bash, and glibc packages to support the new
rlimits yet.

Lee

