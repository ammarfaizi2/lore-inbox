Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUHZSm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUHZSm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269328AbUHZSjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:39:54 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52395 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269170AbUHZSfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:35:48 -0400
Subject: Re: Time of process changes to earlier time in process list
From: Lee Revell <rlrevell@joe-job.com>
To: Norbert van Nobelen <Norbert@edusupport.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093506726.2331.34.camel@linux.local>
References: <1093506726.2331.34.camel@linux.local>
Content-Type: text/plain
Message-Id: <1093545355.5678.66.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 14:35:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 03:52, Norbert van Nobelen wrote:
> Hello,
> 
> I did two times a 'ps -ef' on a red hat machine. The strange part was
> that the time of the following process changed to the past:

Are you running NTP?  Looks like the system clock got corrected between
the first and second 'ps -ef'.

Lee

